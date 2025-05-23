#!/bin/bash

# Fix script for Next.js systemd service
# Usage: sudo ./fix-service.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SERVICE_FILE="/etc/systemd/system/nextjs-app.service"
PROJECT_DIR="/var/www/html"

echo -e "${GREEN}Fixing Next.js systemd service...${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (sudo)${NC}"
    exit 1
fi

# Stop the service first
echo -e "${YELLOW}Stopping nextjs-app service...${NC}"
systemctl stop nextjs-app || true

# Update the service file
echo -e "${YELLOW}Updating service file...${NC}"
cp nextjs-app.service $SERVICE_FILE

# Reload systemd
echo -e "${YELLOW}Reloading systemd daemon...${NC}"
systemctl daemon-reload

# Start the service
echo -e "${YELLOW}Starting nextjs-app service...${NC}"
systemctl start nextjs-app

# Check status
echo -e "${YELLOW}Checking service status...${NC}"
systemctl status nextjs-app --no-pager

echo -e "${GREEN}Service fix completed!${NC}" 