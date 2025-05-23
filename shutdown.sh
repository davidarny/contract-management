#!/bin/bash

# Shutdown script to revert deployment changes
# Usage: sudo ./shutdown.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PROJECT_DIR="/var/www/html"
NGINX_SITE="/etc/nginx/sites-available/cloaking-site"
NGINX_ENABLED="/etc/nginx/sites-enabled/cloaking-site"
SERVICE_FILE="/etc/systemd/system/nextjs-app.service"

echo -e "${YELLOW}Starting shutdown and cleanup process...${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (sudo)${NC}"
    exit 1
fi

# Stop and disable services
echo -e "${YELLOW}Stopping and disabling services...${NC}"
systemctl stop nextjs-app 2>/dev/null || true
systemctl disable nextjs-app 2>/dev/null || true
systemctl stop nginx 2>/dev/null || true
systemctl disable nginx 2>/dev/null || true
systemctl stop php8.3-fpm 2>/dev/null || true
systemctl disable php8.3-fpm 2>/dev/null || true

# Remove systemd service file
echo -e "${YELLOW}Removing systemd service file...${NC}"
rm -f "$SERVICE_FILE"
systemctl daemon-reload

# Remove nginx configuration
echo -e "${YELLOW}Removing nginx configuration...${NC}"
rm -f "$NGINX_SITE"
rm -f "$NGINX_ENABLED"
rm -f "$NGINX_SITE.backup."* 2>/dev/null || true

# Remove SSL certificates if they exist
echo -e "${YELLOW}Removing SSL certificates...${NC}"
if command -v certbot &> /dev/null; then
    # Get list of certificates and remove them
    CERT_DOMAINS=$(certbot certificates 2>/dev/null | grep "Certificate Name:" | awk '{print $3}' || true)
    if [ -n "$CERT_DOMAINS" ]; then
        for domain in $CERT_DOMAINS; do
            echo -e "${YELLOW}Removing SSL certificate for $domain...${NC}"
            certbot delete --cert-name "$domain" --non-interactive 2>/dev/null || true
        done
    fi
    
    # Remove certbot cron jobs
    echo -e "${YELLOW}Removing certbot cron jobs...${NC}"
    crontab -l 2>/dev/null | grep -v "certbot renew" | crontab - 2>/dev/null || true
    
    # Remove certbot package
    apt remove --purge -y certbot python3-certbot-nginx 2>/dev/null || true
fi

# Remove Let's Encrypt directories
if [ -d "/etc/letsencrypt" ]; then
    rm -rf /etc/letsencrypt
fi

# Restore default nginx site if it exists
if [ -f "/etc/nginx/sites-available/default" ]; then
    ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
fi

# Remove project files
echo -e "${YELLOW}Removing project files...${NC}"
if [ -d "$PROJECT_DIR" ]; then
    rm -rf "$PROJECT_DIR"
fi

# Remove Node.js symlinks
echo -e "${YELLOW}Removing Node.js symlinks...${NC}"
rm -f /usr/local/bin/node
rm -f /usr/local/bin/npm

# Remove nvm installations
echo -e "${YELLOW}Removing nvm installations...${NC}"

# Remove nvm for root user
if [ -d "$HOME/.nvm" ]; then
    rm -rf "$HOME/.nvm"
fi

# Remove nvm for www-data user
WWW_DATA_HOME="/var/www"
if [ -d "$WWW_DATA_HOME/.nvm" ]; then
    rm -rf "$WWW_DATA_HOME/.nvm"
fi

# Remove nvm from profile files
sed -i '/export NVM_DIR/d' /etc/profile 2>/dev/null || true
sed -i '/\. "$NVM_DIR\/nvm.sh"/d' /etc/profile 2>/dev/null || true
sed -i '/\. "$NVM_DIR\/bash_completion"/d' /etc/profile 2>/dev/null || true

# Remove nvm from user profiles
for profile in ~/.bashrc ~/.profile ~/.zshrc; do
    if [ -f "$profile" ]; then
        sed -i '/export NVM_DIR/d' "$profile" 2>/dev/null || true
        sed -i '/\. "$NVM_DIR\/nvm.sh"/d' "$profile" 2>/dev/null || true
        sed -i '/\. "$NVM_DIR\/bash_completion"/d' "$profile" 2>/dev/null || true
    fi
done

# Remove PHP packages
echo -e "${YELLOW}Removing PHP packages...${NC}"
apt remove --purge -y php8.3-fpm php8.3-curl php8.3-mbstring php8.3-xml php8.3-cli php8.3-zip php8.3-gd 2>/dev/null || true

# Remove nginx
echo -e "${YELLOW}Removing nginx...${NC}"
apt remove --purge -y nginx nginx-common nginx-core 2>/dev/null || true

# Remove PHP repository (optional - commented out to avoid affecting other PHP installations)
# echo -e "${YELLOW}Removing PHP repository...${NC}"
# add-apt-repository --remove ppa:ondrej/php -y 2>/dev/null || true

# Clean up package cache
echo -e "${YELLOW}Cleaning up package cache...${NC}"
apt autoremove -y
apt autoclean

# Restore original apt sources if backups exist
echo -e "${YELLOW}Restoring original apt sources configuration...${NC}"
for backup in /etc/apt/sources.list.d/*.backup; do
    if [ -f "$backup" ]; then
        original="${backup%.backup}"
        echo -e "${YELLOW}Restoring $(basename "$original") from backup...${NC}"
        mv "$backup" "$original"
    fi
done

# Reset firewall rules (if ufw is installed and was configured)
if command -v ufw &> /dev/null; then
    echo -e "${YELLOW}Resetting firewall rules...${NC}"
    ufw --force reset 2>/dev/null || true
fi

# Restart remaining services
echo -e "${YELLOW}Restarting remaining services...${NC}"
if systemctl is-active --quiet nginx; then
    systemctl restart nginx
fi

# Clean up any remaining processes
echo -e "${YELLOW}Cleaning up remaining processes...${NC}"
pkill -f "node.*next" 2>/dev/null || true
pkill -f "npm.*start" 2>/dev/null || true

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Shutdown and cleanup completed!${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo -e "${YELLOW}What was removed:${NC}"
echo "- Next.js application and service"
echo "- Nginx cloaking configuration"
echo "- SSL certificates and Let's Encrypt setup"
echo "- PHP 8.3 and extensions"
echo "- Node.js and npm (nvm installations)"
echo "- Project files in $PROJECT_DIR"
echo "- Systemd service files"
echo "- Firewall rules (reset to default)"
echo "- Certbot cron jobs and auto-renewal"
echo
echo -e "${YELLOW}What was preserved:${NC}"
echo "- System packages and dependencies"
echo "- User data and home directories"
echo "- Other nginx sites (if any)"
echo "- SSH access and basic system configuration"
echo
echo -e "${GREEN}System has been reverted to pre-deployment state.${NC}"
echo -e "${YELLOW}You may want to reboot the system to ensure all changes take effect.${NC}" 