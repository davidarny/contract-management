# Next.js + PHP Cloaking Service Integration

This project integrates a PHP-based cloaking service with a Next.js application. The cloaking service filters traffic and shows different content based on the visitor's characteristics.

## How It Works

1. **All traffic** goes through the PHP cloaking script (`index.php` in root)
2. The script calls the cloaking API to determine the visitor type
3. Based on the response:
   - **White Page**: Proxies to Next.js application (port 3000)
   - **Offer Page**: Shows the contract management demo (`web/index.php`)

## Architecture

```
Internet → Nginx → PHP Cloaking Script (index.php) → API Check
                                                          ↓
                                White Page → Next.js App (127.0.0.1:3000)
                                Offer Page → web/index.php (Contract Demo)
```

## Requirements

- **Server**: Linux (Ubuntu 20.04+ recommended)
- **PHP**: 7.4+ with extensions: curl, mbstring, json, openssl, filter, xml
- **Node.js**: 18+ with npm (LTS version recommended)
- **Nginx**: Latest stable version
- **Permissions**: allow_url_fopen enabled in php.ini

## File Structure

```
contract-management/
├── index.php              # Cloaking script (MAIN ENTRY POINT)
├── web/
│   └── index.php          # Offer page (Contract Management Demo)
├── nginx.conf             # Nginx configuration
├── nextjs-app.service     # Systemd service for Next.js
├── deploy.sh              # Automated deployment script
├── app/                   # Next.js application (White Page)
├── components/
├── lib/
└── ... (other Next.js files)
```

## Installation

### Option 1: Automated Deployment (Recommended)

1. **Upload files** to your server
2. **Make the script executable**:
   ```bash
   chmod +x deploy.sh
   ```
3. **Run the deployment script**:
   ```bash
   sudo ./deploy.sh your-domain.com
   ```

The script will automatically:

- Add the PHP repository (ondrej/php PPA)
- Detect the best available PHP version (8.3, 8.2, 8.1, 8.0, or 7.4)
- Install all required packages
- Configure services

### Option 2: Manual Setup

#### 1. Add PHP Repository and Install Packages

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install basic dependencies
sudo apt install -y software-properties-common apt-transport-https lsb-release ca-certificates wget curl gnupg

# Add PHP repository
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

# Install packages (replace 8.1 with your preferred version)
sudo apt install -y nginx \
    php8.1-fpm \
    php8.1-curl \
    php8.1-mbstring \
    php8.1-json \
    php8.1-openssl \
    php8.1-xml \
    php8.1-cli \
    nodejs npm
```

#### 2. Install Node.js LTS (if needed)

```bash
# Check Node.js version
node --version

# If version is below 18, install Node.js LTS
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Verify installation
node --version
npm --version
```

#### 3. Configure PHP-FPM

```bash
sudo systemctl enable php8.1-fpm
sudo systemctl start php8.1-fpm
```

#### 4. Set up Project

```bash
# Create directories
sudo mkdir -p /var/www/html/web
sudo chown -R www-data:www-data /var/www/html

# Copy files
sudo cp -r ./* /var/www/html/
sudo chown -R www-data:www-data /var/www/html

# Build Next.js
cd /var/www/html
sudo -u www-data npm install
sudo -u www-data npm run build
```

#### 5. Configure Nginx

```bash
# Copy nginx config
sudo cp nginx.conf /etc/nginx/sites-available/cloaking-site

# Replace domain placeholder
sudo sed -i 's/your-domain.com/YOUR_ACTUAL_DOMAIN/g' /etc/nginx/sites-available/cloaking-site

# Update PHP version in config if needed
sudo sed -i 's/php8\.1-fpm/php8.1-fpm/g' /etc/nginx/sites-available/cloaking-site

# Enable site
sudo ln -sf /etc/nginx/sites-available/cloaking-site /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Test and restart
sudo nginx -t
sudo systemctl restart nginx
```

#### 6. Set up Next.js Service

```bash
# Copy service file
sudo cp nextjs-app.service /etc/systemd/system/

# Enable and start
sudo systemctl daemon-reload
sudo systemctl enable nextjs-app
sudo systemctl start nextjs-app
```

## Configuration

### 1. Cloaking Service Settings

In your cloaking service dashboard:

- **White Page URL**: `http://your-domain.com` (will proxy to Next.js internally)
- **Offer Page URL**: `http://your-domain.com/web/` or external URL
- **Label**: Update the label in `index.php` (line ~104)

### 2. Domain Configuration

1. Point your domain's DNS to your server's IP address
2. Update `nginx.conf` with your actual domain name
3. Restart Nginx: `sudo systemctl restart nginx`

### 3. SSL/HTTPS Setup (Recommended)

Install SSL certificate (using Let's Encrypt):

```bash
# Install certbot
sudo apt install certbot python3-certbot-nginx

# Get certificate
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# Auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

## Testing

### 1. Check Services Status

```bash
sudo systemctl status nextjs-app
sudo systemctl status nginx
sudo systemctl status php8.1-fpm  # Replace with your PHP version
```

### 2. Test Components

1. **Cloaking Script**: Visit your domain directly
2. **Offer Page**: Visit `http://your-domain.com/web/`
3. **Next.js App**: Test directly at `http://localhost:3000`
4. **Check Logs**:
   ```bash
   sudo tail -f /var/log/nginx/cloaking_access.log
   sudo tail -f /var/log/nginx/cloaking_error.log
   sudo journalctl -u nextjs-app -f
   ```

### 3. Direct Component Testing

```bash
# Test if Next.js is running on port 3000
curl http://localhost:3000

# Test offer page directly
curl http://localhost/web/

# Test cloaking script
curl -H "User-Agent: TestBot" http://localhost/
```

## How Cloaking Works

1. **Visitor arrives** at your domain
2. **Nginx** serves the root `index.php` (cloaking script)
3. **PHP script** sends visitor data to Cloaking.House API
4. **API responds** with filtering decision:
   - `filter_page: "white"` → Show Next.js app (proxy to port 3000)
   - `filter_page: "offer"` → Show offer page (`web/index.php`)

## Troubleshooting

### PHP Package Issues

If you get errors like "Unable to locate package php8.1-fpm":

1. **Add PHP Repository**:

   ```bash
   sudo apt install software-properties-common
   sudo add-apt-repository ppa:ondrej/php -y
   sudo apt update
   ```

2. **Check Available PHP Versions**:

   ```bash
   apt search php | grep -E "php[0-9]\.[0-9]-fpm"
   ```

3. **Install Available Version**:
   ```bash
   # Example for PHP 8.0 if 8.1 is not available
   sudo apt install php8.0-fpm php8.0-curl php8.0-mbstring php8.0-json php8.0-openssl
   ```

### Common Issues

1. **PHP Errors**: Check `/var/log/nginx/cloaking_error.log`
2. **Next.js Not Starting**: Check `sudo journalctl -u nextjs-app -f`
3. **Nginx Configuration**: Test with `sudo nginx -t`
4. **Permissions**: Ensure www-data owns files: `sudo chown -R www-data:www-data /var/www/html`
5. **Port 3000 Blocked**: Check firewall and ensure Next.js is running
6. **Old Node.js Version**: Install Node.js LTS using NodeSource repository

### Useful Commands

```bash
# Restart services
sudo systemctl restart nextjs-app
sudo systemctl restart nginx
sudo systemctl restart php8.1-fpm  # Replace with your PHP version

# View logs
sudo journalctl -u nextjs-app -f
sudo tail -f /var/log/nginx/cloaking_*.log

# Check ports
sudo netstat -tlnp | grep :80
sudo netstat -tlnp | grep :3000

# Test connectivity
curl http://127.0.0.1:3000
curl http://localhost/web/

# Check PHP version and modules
php -v
php -m | grep -E "(curl|mbstring|json|openssl)"
```

## Security Considerations

1. **Firewall**: Only allow necessary ports (80, 443, SSH)
2. **Updates**: Keep system and packages updated
3. **Logs**: Monitor access logs for suspicious activity
4. **SSL**: Always use HTTPS in production
5. **File Permissions**: Restrict file access appropriately

## Performance Optimization

1. **Enable Gzip**: Already configured in Nginx
2. **Static Files**: Nginx serves static files directly
3. **Caching**: Configure appropriate cache headers
4. **CDN**: Consider using a CDN for static assets

## Support

- **Cloaking Service**: Contact Cloaking.House support
- **Next.js Issues**: Check Next.js documentation
- **Server Issues**: Check system logs and service status

## Important Notes

⚠️ **Warning**: Do not modify the core cloaking script logic unless absolutely necessary, as it may break the filtering functionality.

✅ **Tip**: Always test changes in a staging environment before deploying to production.

🔒 **Security**: Regularly update all components and monitor for security vulnerabilities.

## Quick Reference

**File Locations:**

- Cloaking Script: `/var/www/html/index.php`
- Offer Page: `/var/www/html/web/index.php`
- Next.js App: Port 3000 (managed by systemd)
- Nginx Config: `/etc/nginx/sites-available/cloaking-site`
- Service File: `/etc/systemd/system/nextjs-app.service`
