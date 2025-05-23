#!/bin/bash

# Fix SSL Certificate Issues Script
# Usage: sudo ./fix-ssl.sh [domain]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOMAIN=${1:-"contractdatahub.tech"}
NGINX_SITE="/etc/nginx/sites-available/cloaking-site"
WEBROOT="/var/www/html"

echo -e "${GREEN}Fixing SSL certificate issues for domain: $DOMAIN${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (sudo)${NC}"
    exit 1
fi

# Check if certbot is installed
if ! command -v certbot &> /dev/null; then
    echo -e "${YELLOW}Installing certbot...${NC}"
    apt update
    apt install -y certbot python3-certbot-nginx
fi

# Ensure webroot directory exists and has proper permissions
echo -e "${YELLOW}Setting up webroot directory...${NC}"
mkdir -p "$WEBROOT/.well-known/acme-challenge"
chown -R www-data:www-data "$WEBROOT/.well-known"
chmod -R 755 "$WEBROOT/.well-known"

# Test webroot accessibility
echo -e "${YELLOW}Testing webroot accessibility...${NC}"
TEST_FILE="$WEBROOT/.well-known/acme-challenge/test-$(date +%s)"
echo "test" > "$TEST_FILE"
chown www-data:www-data "$TEST_FILE"
chmod 644 "$TEST_FILE"

# Test HTTP access to the test file
HTTP_TEST=$(curl -s -o /dev/null -w "%{http_code}" "http://$DOMAIN/.well-known/acme-challenge/$(basename "$TEST_FILE")" 2>/dev/null || echo "000")

if [ "$HTTP_TEST" = "200" ]; then
    echo -e "${GREEN}✓ Webroot is accessible via HTTP${NC}"
else
    echo -e "${RED}✗ Webroot not accessible via HTTP (got $HTTP_TEST)${NC}"
    echo -e "${YELLOW}This might be due to nginx configuration issues${NC}"
fi

# Clean up test file
rm -f "$TEST_FILE"

# Update nginx configuration to ensure proper ACME challenge handling
echo -e "${YELLOW}Updating nginx configuration for ACME challenges...${NC}"
if [ -f "$NGINX_SITE" ]; then
    # Backup current config
    cp "$NGINX_SITE" "$NGINX_SITE.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Update the current config file with the fixed version
    if [ -f "nginx.conf" ]; then
        cp nginx.conf "$NGINX_SITE"
        sed -i "s/your-domain.com/$DOMAIN/g" "$NGINX_SITE"
        
        # Test nginx configuration
        if nginx -t; then
            echo -e "${GREEN}✓ Nginx configuration updated successfully${NC}"
            systemctl reload nginx
        else
            echo -e "${RED}✗ Nginx configuration test failed${NC}"
            # Restore backup
            cp "$NGINX_SITE.backup."* "$NGINX_SITE" 2>/dev/null || true
            exit 1
        fi
    fi
fi

# Check if certificate already exists
if [ -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ]; then
    echo -e "${YELLOW}Certificate exists, testing renewal...${NC}"
    
    # Test renewal
    if certbot renew --cert-name "$DOMAIN" --dry-run; then
        echo -e "${GREEN}✓ Certificate renewal test successful${NC}"
    else
        echo -e "${RED}✗ Certificate renewal test failed${NC}"
        echo -e "${YELLOW}Attempting to force renewal...${NC}"
        
        # Force renewal
        certbot renew --cert-name "$DOMAIN" --force-renewal
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Certificate renewed successfully${NC}"
            systemctl reload nginx
        else
            echo -e "${RED}✗ Certificate renewal failed${NC}"
            echo -e "${YELLOW}You may need to delete and recreate the certificate${NC}"
        fi
    fi
else
    echo -e "${YELLOW}No certificate found, obtaining new certificate...${NC}"
    
    # Obtain new certificate
    certbot certonly --webroot -w "$WEBROOT" -d "$DOMAIN" --email "admin@$DOMAIN" --agree-tos --non-interactive
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ New certificate obtained successfully${NC}"
        systemctl reload nginx
    else
        echo -e "${RED}✗ Failed to obtain certificate${NC}"
        exit 1
    fi
fi

# Verify HTTPS is working
echo -e "${YELLOW}Testing HTTPS endpoint...${NC}"
sleep 2
HTTPS_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "https://$DOMAIN/" 2>/dev/null || echo "000")

if [ "$HTTPS_RESPONSE" = "200" ]; then
    echo -e "${GREEN}✓ HTTPS endpoint working (HTTP $HTTPS_RESPONSE)${NC}"
else
    echo -e "${YELLOW}⚠ HTTPS endpoint returned: $HTTPS_RESPONSE${NC}"
fi

# Check certificate expiration
echo -e "${YELLOW}Certificate Information:${NC}"
certbot certificates | grep -A 10 "$DOMAIN" || echo "Certificate info not available"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}SSL Certificate Fix Completed!${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo -e "${YELLOW}Summary:${NC}"
echo "- Domain: $DOMAIN"
echo "- Webroot: $WEBROOT"
echo "- Certificate path: /etc/letsencrypt/live/$DOMAIN/"
echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Test your site: https://$DOMAIN"
echo "2. Run health check: ./healthcheck.sh --domain $DOMAIN"
echo "3. Monitor renewal: sudo certbot renew --dry-run"
echo
echo -e "${GREEN}SSL issues should now be resolved! 🔒${NC}" 