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

# Clean up apt sources to avoid warnings
echo -e "${YELLOW}Cleaning up apt sources configuration...${NC}"

# Remove duplicate entries in ubuntu-mirrors.list if it exists
if [ -f "/etc/apt/sources.list.d/ubuntu-mirrors.list" ]; then
    echo -e "${YELLOW}Found duplicate sources in ubuntu-mirrors.list, cleaning up...${NC}"
    # Create a backup
    cp /etc/apt/sources.list.d/ubuntu-mirrors.list /etc/apt/sources.list.d/ubuntu-mirrors.list.backup
    # Remove duplicates by keeping only unique lines
    sort /etc/apt/sources.list.d/ubuntu-mirrors.list | uniq > /tmp/ubuntu-mirrors-clean.list
    mv /tmp/ubuntu-mirrors-clean.list /etc/apt/sources.list.d/ubuntu-mirrors.list
fi

# Remove any other potential duplicate source files
for file in /etc/apt/sources.list.d/*.list; do
    if [ -f "$file" ] && [ "$(basename "$file")" != "ubuntu-mirrors.list" ]; then
        # Check if file has duplicate lines and clean if needed
        if [ "$(sort "$file" | uniq | wc -l)" -ne "$(wc -l < "$file")" ]; then
            echo -e "${YELLOW}Cleaning duplicates in $(basename "$file")...${NC}"
            cp "$file" "$file.backup"
            sort "$file" | uniq > "/tmp/$(basename "$file")"
            mv "/tmp/$(basename "$file")" "$file"
        fi
    fi
done

# Update system packages
echo -e "${YELLOW}Updating system packages...${NC}"
apt update && apt upgrade -y

# Install basic dependencies
echo -e "${YELLOW}Installing basic dependencies...${NC}"
apt install -y software-properties-common apt-transport-https lsb-release ca-certificates wget curl gnupg unzip nginx

# Install latest PHP (8.3)
echo -e "${YELLOW}Adding PHP repository and installing PHP 8.3...${NC}"
if ! grep -q "ondrej/php" /etc/apt/sources.list.d/* 2>/dev/null; then
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
    apt update
fi

# Install PHP 8.3 and required extensions
apt install -y php8.3-fpm php8.3-curl php8.3-mbstring php8.3-xml php8.3-cli php8.3-zip php8.3-gd

# Enable and start PHP-FPM
systemctl enable php8.3-fpm
systemctl start php8.3-fpm

# Install Node.js using nvm
echo -e "${YELLOW}Installing Node.js using nvm...${NC}"

# Install nvm for root
echo -e "${YELLOW}Installing nvm for root user...${NC}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node.js 22
nvm install 22
nvm use 22
nvm alias default 22

# Install nvm for www-data user
echo -e "${YELLOW}Installing nvm for www-data user...${NC}"

# Ensure www-data home directory exists and has proper permissions
WWW_DATA_HOME=$(eval echo ~www-data)
if [ ! -d "$WWW_DATA_HOME" ]; then
    mkdir -p "$WWW_DATA_HOME"
fi
chown www-data:www-data "$WWW_DATA_HOME"
chmod 755 "$WWW_DATA_HOME"

# Install nvm for www-data user
sudo -u www-data bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
sudo -u www-data bash -c 'export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install 22 && nvm use 22 && nvm alias default 22'

# Create system-wide symlinks
WWW_DATA_HOME=$(eval echo ~www-data)
echo -e "${YELLOW}www-data home directory: $WWW_DATA_HOME${NC}"

# Find the actual Node.js installation directory
NODE_PATH=""
NPM_PATH=""

# Look for Node.js installation in www-data's nvm directory
if [ -d "$WWW_DATA_HOME/.nvm/versions/node" ]; then
    NODE_VERSION_DIR=$(find "$WWW_DATA_HOME/.nvm/versions/node" -name "v22.*" -type d | head -1)
    if [ -n "$NODE_VERSION_DIR" ] && [ -d "$NODE_VERSION_DIR" ]; then
        NODE_PATH="$NODE_VERSION_DIR/bin/node"
        NPM_PATH="$NODE_VERSION_DIR/bin/npm"
        echo -e "${GREEN}Found Node.js installation at: $NODE_VERSION_DIR${NC}"
    fi
fi

# Create symlinks for system-wide access
if [ -f "$NODE_PATH" ] && [ -f "$NPM_PATH" ]; then
    rm -f /usr/local/bin/node /usr/local/bin/npm
    ln -sf "$NODE_PATH" /usr/local/bin/node
    ln -sf "$NPM_PATH" /usr/local/bin/npm
    echo -e "${GREEN}Created system-wide Node.js symlinks${NC}"
    echo -e "${GREEN}  node -> $NODE_PATH${NC}"
    echo -e "${GREEN}  npm -> $NPM_PATH${NC}"
else
    echo -e "${RED}Could not find Node.js installation for www-data user${NC}"
    echo -e "${YELLOW}Checking what was installed...${NC}"
    ls -la "$WWW_DATA_HOME/.nvm/" 2>/dev/null || echo "No .nvm directory found"
    ls -la "$WWW_DATA_HOME/.nvm/versions/" 2>/dev/null || echo "No versions directory found"
    exit 1
fi

# Verify installation
echo -e "${GREEN}Node.js version: $(node -v)${NC}"
echo -e "${GREEN}npm version: $(npm -v)${NC}"

# Create project directory structure
echo -e "${YELLOW}Setting up project directories...${NC}"
mkdir -p $PROJECT_DIR
mkdir -p $WEB_DIR
chown -R www-data:www-data $PROJECT_DIR

# Copy project files
echo -e "${YELLOW}Copying project files...${NC}"
cp -r ./* $PROJECT_DIR/
chown -R www-data:www-data $PROJECT_DIR

# Build Next.js application
echo -e "${YELLOW}Building Next.js application...${NC}"
cd $PROJECT_DIR

# Run npm commands as www-data with nvm environment
sudo -u www-data bash -c '
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    cd "'$PROJECT_DIR'"
    npm install
    npm run build
'

# Configure Nginx
echo -e "${YELLOW}Configuring Nginx...${NC}"
cp nginx.conf $NGINX_SITE

# Replace domain placeholder in nginx config
sed -i "s/your-domain.com/$DOMAIN/g" $NGINX_SITE

# Update PHP version in nginx config to 8.3
sed -i "s/php8\.1-fpm/php8.3-fpm/g" $NGINX_SITE

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
systemctl status php8.3-fpm --no-pager

# Display final information
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Deployment completed successfully!${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo -e "Domain: ${YELLOW}$DOMAIN${NC}"
echo -e "PHP Version: ${YELLOW}8.3${NC}"
echo -e "Node.js Version: ${YELLOW}$(node -v)${NC}"
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
echo "- Restart PHP-FPM: sudo systemctl restart php8.3-fpm"
echo "- View logs: sudo journalctl -u nextjs-app -f"
echo "- Check status: sudo systemctl status nextjs-app"
echo "- Shutdown/Revert: sudo ./shutdown.sh"
echo
echo -e "${GREEN}Your cloaking service is now running at: http://$DOMAIN${NC}" 