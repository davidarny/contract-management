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
apt install -y software-properties-common apt-transport-https lsb-release ca-certificates wget curl gnupg unzip

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
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-cli

# Install additional PHP packages that may be available (ignore errors for built-in modules)
echo -e "${YELLOW}Installing additional PHP packages (if available)...${NC}"

# For PHP 8.0+, json and openssl are built into core, so we skip them
if [[ "$PHP_VERSION" == "7.4" ]]; then
    ADDITIONAL_PACKAGES="php${PHP_VERSION}-json php${PHP_VERSION}-openssl php${PHP_VERSION}-zip php${PHP_VERSION}-gd"
else
    ADDITIONAL_PACKAGES="php${PHP_VERSION}-zip php${PHP_VERSION}-gd"
    echo -e "${YELLOW}Skipping php${PHP_VERSION}-json and php${PHP_VERSION}-openssl (built into PHP ${PHP_VERSION} core)${NC}"
fi

for package in $ADDITIONAL_PACKAGES; do
    if apt-cache show $package >/dev/null 2>&1; then
        echo -e "${GREEN}Installing $package${NC}"
        apt install -y $package
    else
        echo -e "${YELLOW}$package not available (likely built into PHP core)${NC}"
    fi
done

# Install Node.js using fnm
echo -e "${YELLOW}Checking Node.js installation...${NC}"

# Check if Node.js is already installed and get version
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v | sed 's/v//')
    MAJOR_VERSION=$(echo $NODE_VERSION | cut -d. -f1)
    
    if [ "$MAJOR_VERSION" -ge 18 ]; then
        echo -e "${GREEN}Node.js $NODE_VERSION is already installed and suitable (>= 18.x)${NC}"
        echo -e "${GREEN}npm version: $(npm -v)${NC}"
        echo -e "${YELLOW}Skipping fnm installation${NC}"
        
        # Ensure node and npm are available in system PATH
        NODE_PATH=$(which node)
        NPM_PATH=$(which npm)
        
        if [ ! -L "/usr/local/bin/node" ]; then
            ln -sf "$NODE_PATH" /usr/local/bin/node
        fi
        if [ ! -L "/usr/local/bin/npm" ]; then
            ln -sf "$NPM_PATH" /usr/local/bin/npm
        fi
    else
        echo -e "${YELLOW}Node.js $NODE_VERSION is installed but outdated (< 18.x). Installing newer version with fnm...${NC}"
        INSTALL_FNM=true
    fi
else
    echo -e "${YELLOW}Node.js not found. Installing with fnm...${NC}"
    INSTALL_FNM=true
fi

# Install fnm and Node.js only if needed
if [ "$INSTALL_FNM" = true ]; then
    echo -e "${YELLOW}Installing Node.js using fnm...${NC}"

    # Remove old nodejs if present
    apt remove -y nodejs npm 2>/dev/null || true

    # Install fnm for www-data user (primary installation)
    echo -e "${YELLOW}Installing fnm for www-data user...${NC}"
    
    # Install fnm with timeout and error handling
    if ! timeout 300 sudo -u www-data bash -c 'curl -o- https://fnm.vercel.app/install | bash'; then
        echo -e "${RED}fnm installation for www-data failed or timed out${NC}"
        exit 1
    fi
    
    echo -e "${YELLOW}Installing Node.js 22 for www-data user...${NC}"
    if ! timeout 300 sudo -u www-data bash -c 'export PATH="$HOME/.local/share/fnm:$PATH" && eval "$(fnm env --use-on-cd)" && fnm install 22 && fnm use 22 && fnm default 22'; then
        echo -e "${RED}Node.js installation for www-data failed or timed out${NC}"
        exit 1
    fi

    # Get the www-data fnm paths
    WWW_DATA_HOME=$(eval echo ~www-data)
    WWW_DATA_FNM_DIR="$WWW_DATA_HOME/.local/share/fnm"
    
    # Find the Node.js installation for www-data
    if [ -d "$WWW_DATA_FNM_DIR" ]; then
        WWW_DATA_NODE_DIR=$(find "$WWW_DATA_FNM_DIR/node-versions" -name "installation" -type d | head -1)
        if [ -n "$WWW_DATA_NODE_DIR" ]; then
            # Create system-wide symlinks to www-data's Node.js installation
            rm -f /usr/local/bin/node /usr/local/bin/npm
            ln -sf "$WWW_DATA_NODE_DIR/bin/node" /usr/local/bin/node
            ln -sf "$WWW_DATA_NODE_DIR/bin/npm" /usr/local/bin/npm
            
            echo -e "${GREEN}Created symlinks to www-data's Node.js installation${NC}"
        fi
    fi

    # Also install fnm for root user (for administrative tasks)
    echo -e "${YELLOW}Installing fnm for root user...${NC}"
    if ! timeout 300 bash -c 'curl -o- https://fnm.vercel.app/install | bash'; then
        echo -e "${RED}fnm installation for root failed or timed out${NC}"
        exit 1
    fi

    # Source fnm for current session
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd)"

    # Install Node.js 22 for root
    echo -e "${YELLOW}Installing Node.js 22 for root user...${NC}"
    if ! timeout 300 bash -c 'fnm install 22 && fnm use 22 && fnm default 22'; then
        echo -e "${RED}Node.js installation for root failed or timed out${NC}"
        exit 1
    fi

    # Add fnm to system profile
    echo 'export PATH="$HOME/.local/share/fnm:$PATH"' >> /etc/profile
    echo 'eval "$(fnm env --use-on-cd)"' >> /etc/profile
fi

# Verify final installation
echo -e "${GREEN}Final Node.js version: $(node -v)${NC}"
echo -e "${GREEN}Final npm version: $(npm -v)${NC}"

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

# Get the actual npm and node paths for www-data user
NPM_PATH=""
NODE_PATH=""

# Get www-data home directory
WWW_DATA_HOME=$(eval echo ~www-data)

# First, try to find www-data's fnm installation
if [ -d "$WWW_DATA_HOME/.local/share/fnm" ]; then
    # Find the current/default Node.js version in www-data's fnm
    WWW_DATA_NODE_DIR=$(find "$WWW_DATA_HOME/.local/share/fnm/node-versions" -name "installation" -type d | head -1)
    if [ -n "$WWW_DATA_NODE_DIR" ]; then
        NPM_PATH="$WWW_DATA_NODE_DIR/bin/npm"
        NODE_PATH="$WWW_DATA_NODE_DIR/bin/node"
        echo -e "${GREEN}Found www-data's fnm installation at: $WWW_DATA_NODE_DIR${NC}"
    fi
fi

# Fallback to system paths if www-data's fnm not found
if [ ! -f "$NPM_PATH" ]; then
    echo -e "${YELLOW}Checking system paths for npm...${NC}"
    for path in /usr/local/bin/npm /usr/bin/npm; do
        if [ -f "$path" ]; then
            NPM_PATH="$path"
            NODE_PATH="$(dirname $path)/node"
            break
        fi
    done
fi

if [ ! -f "$NPM_PATH" ]; then
    echo -e "${RED}npm not found in any expected location. Please check Node.js installation.${NC}"
    exit 1
fi

echo -e "${GREEN}Using npm at: $NPM_PATH${NC}"
echo -e "${GREEN}Using node at: $NODE_PATH${NC}"

# Run npm commands as www-data user with proper fnm environment
echo -e "${YELLOW}Installing npm dependencies...${NC}"
sudo -u www-data bash -c "
    export PATH=\"$WWW_DATA_HOME/.local/share/fnm:\$PATH\"
    eval \"\$(fnm env --use-on-cd)\"
    cd \"$PROJECT_DIR\"
    npm install
"

echo -e "${YELLOW}Building Next.js application...${NC}"
sudo -u www-data bash -c "
    export PATH=\"$WWW_DATA_HOME/.local/share/fnm:\$PATH\"
    eval \"\$(fnm env --use-on-cd)\"
    cd \"$PROJECT_DIR\"
    npm run build
"

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