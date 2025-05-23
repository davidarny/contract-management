#!/bin/bash

# Shutdown script for Next.js + PHP Cloaking Service
# This script reverts all changes made by deploy.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PROJECT_DIR="/var/www/html"
WEB_DIR="$PROJECT_DIR/web"
NGINX_SITE="/etc/nginx/sites-available/cloaking-site"
NGINX_ENABLED="/etc/nginx/sites-enabled/cloaking-site"
SERVICE_FILE="/etc/systemd/system/nextjs-app.service"

echo -e "${RED}========================================${NC}"
echo -e "${RED}CLOAKING SERVICE SHUTDOWN SCRIPT${NC}"
echo -e "${RED}========================================${NC}"
echo -e "${YELLOW}This will remove all components installed by deploy.sh${NC}"
echo
read -p "Are you sure you want to continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo -e "${GREEN}Shutdown cancelled.${NC}"
    exit 0
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (sudo)${NC}"
    exit 1
fi

echo -e "${YELLOW}Starting shutdown process...${NC}"

# Stop and disable services
echo -e "${YELLOW}Stopping and disabling services...${NC}"
systemctl stop nextjs-app 2>/dev/null || echo -e "${YELLOW}nextjs-app service not running${NC}"
systemctl disable nextjs-app 2>/dev/null || echo -e "${YELLOW}nextjs-app service not enabled${NC}"

systemctl stop nginx 2>/dev/null || echo -e "${YELLOW}nginx service not running${NC}"
systemctl disable nginx 2>/dev/null || echo -e "${YELLOW}nginx service not disabled${NC}"

# Find and stop PHP-FPM services
for php_version in 8.3 8.2 8.1 8.0 7.4; do
    if systemctl is-active --quiet php${php_version}-fpm 2>/dev/null; then
        echo -e "${YELLOW}Stopping PHP ${php_version}-FPM...${NC}"
        systemctl stop php${php_version}-fpm
        systemctl disable php${php_version}-fpm
    fi
done

# Remove systemd service file
echo -e "${YELLOW}Removing systemd service files...${NC}"
rm -f $SERVICE_FILE
systemctl daemon-reload

# Remove nginx configuration
echo -e "${YELLOW}Removing nginx configuration...${NC}"
rm -f $NGINX_SITE
rm -f $NGINX_ENABLED

# Restore default nginx site
echo -e "${YELLOW}Restoring default nginx site...${NC}"
if [ -f /etc/nginx/sites-available/default ]; then
    ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
fi

# Remove project files and directories
echo -e "${YELLOW}Removing project files...${NC}"
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${YELLOW}Removing $PROJECT_DIR${NC}"
    rm -rf "$PROJECT_DIR"
fi

# Remove fnm and Node.js installation
echo -e "${YELLOW}Removing fnm and Node.js...${NC}"

# Remove for root user
if [ -d "$HOME/.local/share/fnm" ]; then
    rm -rf "$HOME/.local/share/fnm"
fi

# Remove for www-data user
if [ -d "/var/lib/www-data/.local/share/fnm" ]; then
    rm -rf "/var/lib/www-data/.local/share/fnm"
fi

# Remove symbolic links
rm -f /usr/local/bin/node
rm -f /usr/local/bin/npm

# Remove fnm from system profile
echo -e "${YELLOW}Cleaning system profile...${NC}"
sed -i '/export PATH=.*fnm/d' /etc/profile 2>/dev/null || true
sed -i '/eval.*fnm env/d' /etc/profile 2>/dev/null || true

# Remove PHP packages
echo -e "${YELLOW}Removing PHP packages...${NC}"
PHP_PACKAGES_TO_REMOVE=""

# Find installed PHP packages
for php_version in 8.3 8.2 8.1 8.0 7.4; do
    for package in fpm curl mbstring xml cli json openssl zip gd; do
        if dpkg -l | grep -q "php${php_version}-${package}"; then
            PHP_PACKAGES_TO_REMOVE="$PHP_PACKAGES_TO_REMOVE php${php_version}-${package}"
        fi
    done
done

if [ -n "$PHP_PACKAGES_TO_REMOVE" ]; then
    echo -e "${YELLOW}Removing PHP packages: $PHP_PACKAGES_TO_REMOVE${NC}"
    apt remove -y $PHP_PACKAGES_TO_REMOVE
fi

# Remove nginx
echo -e "${YELLOW}Removing nginx...${NC}"
apt remove -y nginx nginx-common nginx-core 2>/dev/null || echo -e "${YELLOW}nginx packages not found${NC}"

# Remove PHP repository (optional - commented out to avoid affecting other projects)
# echo -e "${YELLOW}Removing PHP repository...${NC}"
# add-apt-repository --remove ppa:ondrej/php -y 2>/dev/null || echo -e "${YELLOW}PHP repository not found${NC}"

# Clean up packages
echo -e "${YELLOW}Cleaning up unused packages...${NC}"
apt autoremove -y
apt autoclean

# Remove firewall rules (if ufw is installed and enabled)
if command -v ufw &> /dev/null; then
    echo -e "${YELLOW}Removing firewall rules...${NC}"
    ufw delete allow 'Nginx Full' 2>/dev/null || echo -e "${YELLOW}Nginx firewall rule not found${NC}"
    ufw delete allow 'Nginx HTTP' 2>/dev/null || echo -e "${YELLOW}Nginx HTTP firewall rule not found${NC}"
    ufw delete allow 'Nginx HTTPS' 2>/dev/null || echo -e "${YELLOW}Nginx HTTPS firewall rule not found${NC}"
fi

# Clean up any remaining processes on port 3000
echo -e "${YELLOW}Cleaning up processes on port 3000...${NC}"
lsof -ti:3000 | xargs kill -9 2>/dev/null || echo -e "${YELLOW}No processes found on port 3000${NC}"

# Remove any remaining log files
echo -e "${YELLOW}Cleaning up log files...${NC}"
rm -f /var/log/nginx/cloaking_*.log

# Final cleanup
echo -e "${YELLOW}Performing final cleanup...${NC}"

# Update package lists
apt update

# Display summary
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}SHUTDOWN COMPLETED SUCCESSFULLY!${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo -e "${YELLOW}Removed components:${NC}"
echo "- Next.js application and systemd service"
echo "- Nginx web server and configuration"
echo "- PHP-FPM and related packages"
echo "- fnm and Node.js installation"
echo "- Project files in $PROJECT_DIR"
echo "- Firewall rules for web traffic"
echo "- Log files and temporary data"
echo
echo -e "${YELLOW}Preserved components:${NC}"
echo "- PHP repository (to avoid affecting other projects)"
echo "- Basic system packages and dependencies"
echo "- SSH access and firewall SSH rules"
echo "- System users and basic configuration"
echo
echo -e "${GREEN}Your system has been restored to its pre-deployment state.${NC}"
echo -e "${YELLOW}Note: You may want to reboot the system to ensure all changes take effect.${NC}"
echo
read -p "Would you like to reboot now? (yes/no): " reboot_confirm
if [ "$reboot_confirm" = "yes" ]; then
    echo -e "${GREEN}Rebooting system...${NC}"
    reboot
fi 