#!/bin/bash

# Update Nginx Configuration Script
# Usage: sudo ./update-nginx.sh [domain]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
DOMAIN=${1:-"your-domain.com"}
NGINX_SITE="/etc/nginx/sites-available/cloaking-site"
NGINX_ENABLED="/etc/nginx/sites-enabled/cloaking-site"

echo -e "${GREEN}Updating Nginx configuration for domain: $DOMAIN${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (sudo)${NC}"
    exit 1
fi

# Check if nginx config file exists locally
if [ ! -f "nginx.conf" ]; then
    echo -e "${RED}nginx.conf file not found in current directory!${NC}"
    exit 1
fi

# Backup current nginx configuration
if [ -f "$NGINX_SITE" ]; then
    echo -e "${YELLOW}Backing up current nginx configuration...${NC}"
    cp "$NGINX_SITE" "$NGINX_SITE.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Copy new nginx configuration
echo -e "${YELLOW}Installing updated nginx configuration...${NC}"
cp nginx.conf "$NGINX_SITE"

# Replace domain placeholder with actual domain
echo -e "${YELLOW}Updating domain configuration...${NC}"
sed -i "s/your-domain.com/$DOMAIN/g" "$NGINX_SITE"

# Test nginx configuration
echo -e "${YELLOW}Testing nginx configuration...${NC}"
if nginx -t; then
    echo -e "${GREEN}✓ Nginx configuration test passed${NC}"
else
    echo -e "${RED}✗ Nginx configuration test failed!${NC}"
    echo -e "${YELLOW}Restoring backup configuration...${NC}"
    if [ -f "$NGINX_SITE.backup."* ]; then
        cp "$NGINX_SITE.backup."* "$NGINX_SITE" 2>/dev/null || true
        nginx -t
    fi
    exit 1
fi

# Reload nginx
echo -e "${YELLOW}Reloading nginx...${NC}"
systemctl reload nginx

# Check nginx status
echo -e "${YELLOW}Checking nginx status...${NC}"
if systemctl is-active --quiet nginx; then
    echo -e "${GREEN}✓ Nginx is running successfully${NC}"
    systemctl status nginx --no-pager -l | head -10
else
    echo -e "${RED}✗ Nginx failed to start${NC}"
    echo -e "${YELLOW}Checking nginx logs...${NC}"
    journalctl -u nginx --no-pager -l --since "1 minute ago"
    exit 1
fi

# Test HTTP endpoint
echo -e "${YELLOW}Testing HTTP endpoint...${NC}"
HTTP_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "http://$DOMAIN/" 2>/dev/null || echo "000")

if [ "$HTTP_RESPONSE" = "301" ] || [ "$HTTP_RESPONSE" = "200" ]; then
    echo -e "${GREEN}✓ HTTP endpoint responding (HTTP $HTTP_RESPONSE)${NC}"
else
    echo -e "${YELLOW}⚠ HTTP endpoint returned: $HTTP_RESPONSE${NC}"
fi

# Test HTTPS endpoint if SSL is configured
if [ -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ]; then
    echo -e "${YELLOW}Testing HTTPS endpoint...${NC}"
    HTTPS_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "https://$DOMAIN/" 2>/dev/null || echo "000")
    
    if [ "$HTTPS_RESPONSE" = "200" ]; then
        echo -e "${GREEN}✓ HTTPS endpoint responding (HTTP $HTTPS_RESPONSE)${NC}"
    else
        echo -e "${YELLOW}⚠ HTTPS endpoint returned: $HTTPS_RESPONSE${NC}"
    fi
else
    echo -e "${YELLOW}ℹ SSL certificates not found - HTTPS not configured yet${NC}"
    echo -e "${YELLOW}  Run: sudo ./setup-ssl.sh $DOMAIN${NC}"
fi

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Nginx configuration update completed!${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo -e "${YELLOW}Configuration Details:${NC}"
echo "- Domain: $DOMAIN"
echo "- Config file: $NGINX_SITE"
echo "- Backup created: $NGINX_SITE.backup.$(date +%Y%m%d_%H%M%S)"
echo
echo -e "${YELLOW}Next Steps:${NC}"
if [ ! -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ]; then
    echo "1. Set up SSL: sudo ./setup-ssl.sh $DOMAIN your-email@domain.com"
    echo "2. Run health check: ./healthcheck.sh --domain $DOMAIN"
else
    echo "1. Run health check: ./healthcheck.sh --domain $DOMAIN"
    echo "2. Monitor logs: sudo tail -f /var/log/nginx/cloaking_access.log"
fi
echo
echo -e "${GREEN}Nginx is ready! 🚀${NC}" 