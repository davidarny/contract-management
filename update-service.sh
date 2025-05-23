#!/bin/bash

# Update Next.js Service Script
# Usage: sudo ./update-service.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SERVICE_FILE="/etc/systemd/system/nextjs-app.service"

echo -e "${GREEN}Updating Next.js systemd service...${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run this script as root (sudo)${NC}"
    exit 1
fi

# Check if service file exists locally
if [ ! -f "nextjs-app.service" ]; then
    echo -e "${RED}nextjs-app.service file not found in current directory!${NC}"
    exit 1
fi

# Backup current service file
if [ -f "$SERVICE_FILE" ]; then
    echo -e "${YELLOW}Backing up current service file...${NC}"
    cp "$SERVICE_FILE" "$SERVICE_FILE.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Copy new service file
echo -e "${YELLOW}Installing updated service file...${NC}"
cp nextjs-app.service "$SERVICE_FILE"

# Reload systemd
echo -e "${YELLOW}Reloading systemd daemon...${NC}"
systemctl daemon-reload

# Restart the service
echo -e "${YELLOW}Restarting Next.js service...${NC}"
systemctl restart nextjs-app

# Check status
echo -e "${YELLOW}Checking service status...${NC}"
if systemctl is-active --quiet nextjs-app; then
    echo -e "${GREEN}✓ Next.js service is running successfully${NC}"
    systemctl status nextjs-app --no-pager -l
else
    echo -e "${RED}✗ Next.js service failed to start${NC}"
    echo -e "${YELLOW}Checking logs...${NC}"
    journalctl -u nextjs-app --no-pager -l --since "1 minute ago"
    exit 1
fi

echo -e "${GREEN}Service update completed successfully!${NC}" 