#!/bin/bash

# Deployment script for Next.js + PHP Cloaking Service
# Usage: ./deploy.sh [domain]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
DOMAIN=${1:-"your-domain.com"}
PROJECT_DIR="/var/www/html"
WEB_DIR="$PROJECT_DIR/web"
NGINX_SITE="/etc/nginx/sites-available/cloaking-site"
NGINX_ENABLED="/etc/nginx/sites-enabled/cloaking-site"
SERVICE_FILE="/etc/systemd/system/nextjs-app.service"

echo -e "${GREEN}Starting deployment for domain: $DOMAIN${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (sudo)${NC}"
    exit 1
fi

# Update system packages
echo -e "${YELLOW}Updating system packages...${NC}"
apt update && apt upgrade -y

# Install basic dependencies
echo -e "${YELLOW}Installing basic dependencies...${NC}"
apt install -y software-properties-common apt-transport-https lsb-release ca-certificates wget curl gnupg

# Add PHP repository (ondrej/php PPA)
echo -e "${YELLOW}Adding PHP repository...${NC}"
if ! grep -q "ondrej/php" /etc/apt/sources.list.d/*; then
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
    apt update
fi

# Detect available PHP version
echo -e "${YELLOW}Detecting available PHP version...${NC}"
PHP_VERSION=""
for version in 8.3 8.2 8.1 8.0 7.4; do
    if apt-cache show php${version}-fpm >/dev/null 2>&1; then
        PHP_VERSION=${version}
        echo -e "${GREEN}Found PHP ${PHP_VERSION}${NC}"
        break
    fi
done

if [ -z "$PHP_VERSION" ]; then
    echo -e "${RED}No suitable PHP version found. Please install PHP manually.${NC}"
    exit 1
fi

# Install required packages
echo -e "${YELLOW}Installing required packages...${NC}"
apt install -y nginx \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-cli \
    nodejs npm

# Install Node.js LTS if the default version is too old
echo -e "${YELLOW}Checking Node.js version...${NC}"
NODE_VERSION=$(node --version 2>/dev/null | sed 's/v//' | cut -d. -f1 || echo "0")
if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${YELLOW}Installing Node.js LTS...${NC}"
    
    # Remove old nodejs if present
    apt remove -y nodejs npm 2>/dev/null || true
    
    # Add NodeSource repository for LTS
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    apt install -y nodejs
    
    echo -e "${GREEN}Installed Node.js $(node --version) and npm $(npm --version)${NC}"
else
    echo -e "${GREEN}Node.js $(node --version) is already installed and compatible${NC}"
fi

# Enable and start PHP-FPM
echo -e "${YELLOW}Configuring PHP-FPM...${NC}"
systemctl enable php${PHP_VERSION}-fpm
systemctl start php${PHP_VERSION}-fpm

# Create project directory structure
echo -e "${YELLOW}Setting up project directories...${NC}"
mkdir -p $PROJECT_DIR
mkdir -p $WEB_DIR
chown -R www-data:www-data $PROJECT_DIR

# Copy project files (assuming they're in current directory)
echo -e "${YELLOW}Copying project files...${NC}"
cp -r ./* $PROJECT_DIR/
chown -R www-data:www-data $PROJECT_DIR

# Build Next.js application
echo -e "${YELLOW}Building Next.js application...${NC}"
cd $PROJECT_DIR
sudo -u www-data npm install
sudo -u www-data npm run build

# Configure Nginx
echo -e "${YELLOW}Configuring Nginx...${NC}"
cp nginx.conf $NGINX_SITE

# Replace domain placeholder in nginx config
sed -i "s/your-domain.com/$DOMAIN/g" $NGINX_SITE

# Update PHP version in nginx config
sed -i "s/php8\.1-fpm/php${PHP_VERSION}-fpm/g" $NGINX_SITE

# Enable the site
ln -sf $NGINX_SITE $NGINX_ENABLED

# Remove default nginx site if it exists
rm -f /etc/nginx/sites-enabled/default

# Test nginx configuration
nginx -t
if [ $? -ne 0 ]; then
    echo -e "${RED}Nginx configuration test failed!${NC}"
    exit 1
fi

# Configure systemd service for Next.js
echo -e "${YELLOW}Setting up Next.js service...${NC}"
cp nextjs-app.service $SERVICE_FILE

# Update service file with correct paths
sed -i "s|WorkingDirectory=/var/www/html|WorkingDirectory=$PROJECT_DIR|g" $SERVICE_FILE

# Reload systemd and enable services
systemctl daemon-reload
systemctl enable nextjs-app
systemctl start nextjs-app

# Start/restart nginx
systemctl enable nginx
systemctl restart nginx

# Configure firewall (if ufw is installed)
if command -v ufw &> /dev/null; then
    echo -e "${YELLOW}Configuring firewall...${NC}"
    ufw allow 'Nginx Full'
    ufw allow ssh
    ufw --force enable
fi

# Check service status
echo -e "${YELLOW}Checking service status...${NC}"
echo "Next.js service status:"
systemctl status nextjs-app --no-pager

echo "Nginx service status:"
systemctl status nginx --no-pager

echo "PHP-FPM service status:"
systemctl status php${PHP_VERSION}-fpm --no-pager

# Display final information
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Deployment completed successfully!${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo -e "Domain: ${YELLOW}$DOMAIN${NC}"
echo -e "PHP Version: ${YELLOW}${PHP_VERSION}${NC}"
echo -e "Project Directory: ${YELLOW}$PROJECT_DIR${NC}"
echo -e "Cloaking Script: ${YELLOW}$PROJECT_DIR/index.php${NC}"
echo -e "Offer Page: ${YELLOW}$WEB_DIR/index.php${NC}"
echo -e "White Page: ${YELLOW}Next.js (port 3000)${NC}"
echo
echo -e "${YELLOW}Important Notes:${NC}"
echo "1. Update your DNS to point $DOMAIN to this server's IP"
echo "2. Configure SSL certificates for HTTPS (recommended)"
echo "3. Update the cloaking service configuration in the web interface"
echo "4. Set your white page URL to: http://$DOMAIN (will proxy to Next.js)"
echo "5. Set your offer page URL to: http://$DOMAIN/web/ (or any external URL)"
echo "6. Monitor logs: /var/log/nginx/cloaking_*.log"
echo
echo -e "${YELLOW}File Structure:${NC}"
echo "- $PROJECT_DIR/index.php (Cloaking Script - Main Entry Point)"
echo "- $WEB_DIR/index.php (Offer Page - Contract Management Demo)"  
echo "- Next.js App (White Page - running on 127.0.0.1:3000)"
echo
echo -e "${YELLOW}Useful Commands:${NC}"
echo "- Restart Next.js: sudo systemctl restart nextjs-app"
echo "- Restart Nginx: sudo systemctl restart nginx"
echo "- Restart PHP-FPM: sudo systemctl restart php${PHP_VERSION}-fpm"
echo "- View logs: sudo journalctl -u nextjs-app -f"
echo "- Check status: sudo systemctl status nextjs-app"
echo
echo -e "${GREEN}Your cloaking service is now running at: http://$DOMAIN${NC}" 