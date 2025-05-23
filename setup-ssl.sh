#!/bin/bash

# SSL Setup Script for Cloaking Service
# Usage: sudo ./setup-ssl.sh [domain] [email]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOMAIN=${1:-"contractdatahub.tech"}
EMAIL=${2:-"support@$DOMAIN"}
NGINX_SITE="/etc/nginx/sites-available/cloaking-site"
NGINX_ENABLED="/etc/nginx/sites-enabled/cloaking-site"

echo -e "${GREEN}Setting up SSL for domain: $DOMAIN${NC}"
echo -e "${YELLOW}Email for Let's Encrypt: $EMAIL${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (sudo)${NC}"
    exit 1
fi

# Check if domain resolves to this server
echo -e "${YELLOW}Checking DNS resolution...${NC}"
SERVER_IP=$(curl -s ifconfig.me 2>/dev/null || curl -s ipinfo.io/ip 2>/dev/null || echo "unknown")
DOMAIN_IP=$(dig +short "$DOMAIN" 2>/dev/null | tail -1)

if [ "$SERVER_IP" != "$DOMAIN_IP" ]; then
    echo -e "${YELLOW}Warning: Domain $DOMAIN resolves to $DOMAIN_IP but server IP is $SERVER_IP${NC}"
    echo -e "${YELLOW}Make sure your DNS is properly configured before continuing.${NC}"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo -e "${GREEN}DNS resolution looks good: $DOMAIN -> $SERVER_IP${NC}"
fi

# Install certbot
echo -e "${YELLOW}Installing certbot...${NC}"
apt update
apt install -y certbot python3-certbot-nginx

# Test nginx configuration
echo -e "${YELLOW}Testing nginx configuration...${NC}"
nginx -t
if [ $? -ne 0 ]; then
    echo -e "${RED}Nginx configuration test failed! Please fix before continuing.${NC}"
    exit 1
fi

# Backup current nginx configuration
echo -e "${YELLOW}Backing up nginx configuration...${NC}"
cp "$NGINX_SITE" "$NGINX_SITE.backup.$(date +%Y%m%d_%H%M%S)"

# Create temporary nginx config for Let's Encrypt validation
echo -e "${YELLOW}Creating temporary nginx config for SSL validation...${NC}"
cat > "$NGINX_SITE" << EOF
server {
    listen 80;
    server_name $DOMAIN;
    
    # Let's Encrypt validation
    location /.well-known/acme-challenge/ {
        root /var/www/html;
        try_files \$uri =404;
    }
    
    # Temporary redirect to HTTPS (will be updated after SSL setup)
    location / {
        return 301 https://\$server_name\$request_uri;
    }
}
EOF

# Reload nginx with temporary config
systemctl reload nginx

# Obtain SSL certificate
echo -e "${YELLOW}Obtaining SSL certificate from Let's Encrypt...${NC}"
certbot certonly --webroot -w /var/www/html -d "$DOMAIN" --email "$EMAIL" --agree-tos --non-interactive

if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to obtain SSL certificate!${NC}"
    echo -e "${YELLOW}Restoring backup configuration...${NC}"
    cp "$NGINX_SITE.backup."* "$NGINX_SITE" 2>/dev/null || true
    systemctl reload nginx
    exit 1
fi

# Create full nginx configuration with SSL
echo -e "${YELLOW}Creating SSL-enabled nginx configuration...${NC}"
cat > "$NGINX_SITE" << EOF
# HTTP to HTTPS redirect
server {
    listen 80;
    server_name $DOMAIN;
    return 301 https://\$server_name\$request_uri;
}

# HTTPS server
server {
    listen 443 ssl http2;
    server_name $DOMAIN;
    
    # SSL Configuration
    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
    
    # SSL Security Settings
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!SRP:!CAMELLIA;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    
    # HSTS (optional but recommended)
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    
    # Security headers
    add_header X-Frame-Options DENY always;
    add_header X-Content-Type-Options nosniff always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    
    # Document root
    root /var/www/html;
    index index.php index.html index.htm;
    
    # Logging
    access_log /var/log/nginx/cloaking_access.log;
    error_log /var/log/nginx/cloaking_error.log;
    
    # Main cloaking logic - all requests go to index.php
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }
    
    # PHP processing
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
        
        # Security
        fastcgi_hide_header X-Powered-By;
    }
    
    # Deny access to sensitive files
    location ~ /\. {
        deny all;
    }
    
    location ~ /(\.htaccess|\.htpasswd|\.env|composer\.json|composer\.lock|package\.json|package-lock\.json) {
        deny all;
    }
    
    # Let's Encrypt renewal
    location /.well-known/acme-challenge/ {
        root /var/www/html;
        try_files \$uri =404;
    }
}
EOF

# Test new configuration
echo -e "${YELLOW}Testing new SSL configuration...${NC}"
nginx -t
if [ $? -ne 0 ]; then
    echo -e "${RED}New SSL configuration test failed!${NC}"
    echo -e "${YELLOW}Restoring backup configuration...${NC}"
    cp "$NGINX_SITE.backup."* "$NGINX_SITE" 2>/dev/null || true
    systemctl reload nginx
    exit 1
fi

# Reload nginx with SSL configuration
echo -e "${YELLOW}Reloading nginx with SSL configuration...${NC}"
systemctl reload nginx

# Set up automatic renewal
echo -e "${YELLOW}Setting up automatic SSL renewal...${NC}"
# Test renewal
certbot renew --dry-run

if [ $? -eq 0 ]; then
    echo -e "${GREEN}SSL renewal test successful!${NC}"
    
    # Add cron job for automatic renewal (if not already exists)
    if ! crontab -l 2>/dev/null | grep -q "certbot renew"; then
        echo -e "${YELLOW}Adding automatic renewal cron job...${NC}"
        (crontab -l 2>/dev/null; echo "0 12 * * * /usr/bin/certbot renew --quiet && systemctl reload nginx") | crontab -
    fi
else
    echo -e "${YELLOW}SSL renewal test failed, but certificate is installed${NC}"
fi

# Update firewall if ufw is active
if command -v ufw &> /dev/null && ufw status | grep -q "Status: active"; then
    echo -e "${YELLOW}Updating firewall rules for HTTPS...${NC}"
    ufw allow 'Nginx Full'
fi

# Test HTTPS endpoint
echo -e "${YELLOW}Testing HTTPS endpoint...${NC}"
sleep 2
HTTPS_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "https://$DOMAIN/" 2>/dev/null || echo "000")

if [ "$HTTPS_RESPONSE" = "200" ]; then
    echo -e "${GREEN}HTTPS endpoint test successful!${NC}"
else
    echo -e "${YELLOW}HTTPS endpoint returned: $HTTPS_RESPONSE${NC}"
fi

# Display SSL certificate info
echo -e "${YELLOW}SSL Certificate Information:${NC}"
certbot certificates | grep -A 10 "$DOMAIN" || echo "Certificate info not available"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}SSL Setup Completed Successfully!${NC}"
echo -e "${GREEN}========================================${NC}"
echo
echo -e "Domain: ${YELLOW}$DOMAIN${NC}"
echo -e "HTTPS URL: ${YELLOW}https://$DOMAIN${NC}"
echo -e "Certificate Path: ${YELLOW}/etc/letsencrypt/live/$DOMAIN/${NC}"
echo -e "Auto-renewal: ${YELLOW}Enabled (daily check at 12:00)${NC}"
echo
echo -e "${YELLOW}Important Notes:${NC}"
echo "1. Your site now redirects HTTP to HTTPS automatically"
echo "2. SSL certificate will auto-renew before expiration"
echo "3. Security headers are enabled for better protection"
echo "4. All cloaking functionality preserved with HTTPS"
echo
echo -e "${YELLOW}Test your SSL setup:${NC}"
echo "- Visit: https://$DOMAIN"
echo "- SSL Test: https://www.ssllabs.com/ssltest/analyze.html?d=$DOMAIN"
echo "- Check renewal: sudo certbot renew --dry-run"
echo
echo -e "${YELLOW}Useful Commands:${NC}"
echo "- Check certificates: sudo certbot certificates"
echo "- Renew manually: sudo certbot renew"
echo "- Check nginx config: sudo nginx -t"
echo "- View SSL logs: sudo tail -f /var/log/letsencrypt/letsencrypt.log"
echo
echo -e "${GREEN}Your cloaking service is now secured with HTTPS! 🔒${NC}" 