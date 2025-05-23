#!/bin/bash

# Health Check Script for Cloaking Service
# Usage: ./healthcheck.sh [--verbose] [--domain your-domain.com]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOMAIN="localhost"
VERBOSE=false
PROJECT_DIR="/var/www/html"
WEB_DIR="$PROJECT_DIR/web"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose|-v)
            VERBOSE=true
            shift
            ;;
        --domain|-d)
            DOMAIN="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [--verbose] [--domain your-domain.com]"
            echo "  --verbose, -v    Show detailed output"
            echo "  --domain, -d     Specify domain to test (default: localhost)"
            echo "  --help, -h       Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Status tracking
OVERALL_STATUS=0
CHECKS_PASSED=0
CHECKS_TOTAL=0

# Helper functions
print_status() {
    local status=$1
    local message=$2
    local details=$3
    
    CHECKS_TOTAL=$((CHECKS_TOTAL + 1))
    
    if [ $status -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $message"
        CHECKS_PASSED=$((CHECKS_PASSED + 1))
    else
        echo -e "${RED}✗${NC} $message"
        OVERALL_STATUS=1
    fi
    
    if [ "$VERBOSE" = true ] && [ -n "$details" ]; then
        echo -e "  ${BLUE}→${NC} $details"
    fi
}

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

check_service() {
    local service=$1
    local name=$2
    
    if systemctl is-active --quiet "$service"; then
        print_status 0 "$name is running"
        if [ "$VERBOSE" = true ]; then
            local status=$(systemctl status "$service" --no-pager -l | head -3 | tail -1)
            print_status 0 "" "$status"
        fi
    else
        print_status 1 "$name is not running"
        if [ "$VERBOSE" = true ]; then
            local status=$(systemctl status "$service" --no-pager -l 2>/dev/null | grep "Active:" || echo "Service not found")
            print_status 1 "" "$status"
        fi
    fi
}

check_port() {
    local port=$1
    local service=$2
    
    if ss -tlnp | grep -q ":$port "; then
        print_status 0 "Port $port is open ($service)"
        if [ "$VERBOSE" = true ]; then
            local details=$(ss -tlnp | grep ":$port " | head -1)
            print_status 0 "" "$details"
        fi
    else
        print_status 1 "Port $port is not open ($service)"
    fi
}

check_url() {
    local url=$1
    local expected_code=$2
    local description=$3
    
    local response=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url" 2>/dev/null)
    
    if [ "$response" = "$expected_code" ]; then
        print_status 0 "$description (HTTP $response)"
    else
        print_status 1 "$description (Expected HTTP $expected_code, got $response)"
    fi
    
    if [ "$VERBOSE" = true ]; then
        local headers=$(curl -s -I --max-time 5 "$url" 2>/dev/null | head -3 | tr '\n' ' ')
        print_status 0 "" "Headers: $headers"
    fi
}

check_file() {
    local file=$1
    local description=$2
    
    if [ -f "$file" ]; then
        print_status 0 "$description exists"
        if [ "$VERBOSE" = true ]; then
            local size=$(ls -lh "$file" | awk '{print $5}')
            local modified=$(ls -l "$file" | awk '{print $6, $7, $8}')
            print_status 0 "" "Size: $size, Modified: $modified"
        fi
    else
        print_status 1 "$description does not exist"
    fi
}

check_directory() {
    local dir=$1
    local description=$2
    
    if [ -d "$dir" ]; then
        print_status 0 "$description exists"
        if [ "$VERBOSE" = true ]; then
            local files=$(ls -la "$dir" | wc -l)
            local owner=$(ls -ld "$dir" | awk '{print $3":"$4}')
            print_status 0 "" "Files: $((files-2)), Owner: $owner"
        fi
    else
        print_status 1 "$description does not exist"
    fi
}

# Start health check
echo -e "${GREEN}Cloaking Service Health Check${NC}"
echo -e "Domain: ${YELLOW}$DOMAIN${NC}"
echo -e "Time: ${YELLOW}$(date)${NC}"
echo

# System Services Check
print_header "System Services"
check_service "nginx" "Nginx"
check_service "php8.3-fpm" "PHP-FPM 8.3"
check_service "nextjs-app" "Next.js Application"

echo

# Network Ports Check
print_header "Network Ports"
check_port "80" "HTTP"
check_port "443" "HTTPS"
check_port "3000" "Next.js"
check_port "9000" "PHP-FPM"

echo

# File System Check
print_header "File System"
check_file "$PROJECT_DIR/index.php" "Main cloaking script"
check_file "$WEB_DIR/index.php" "Offer page"
check_file "/etc/nginx/sites-enabled/cloaking-site" "Nginx configuration"
check_file "/etc/systemd/system/nextjs-app.service" "Systemd service file"
check_directory "$PROJECT_DIR/.next" "Next.js build directory"
check_directory "$PROJECT_DIR/node_modules" "Node.js modules"

echo

# Web Endpoints Check
print_header "Web Endpoints"

# Test main cloaking endpoint
check_url "http://$DOMAIN/" "200" "Main cloaking endpoint"

# Test offer page directly
check_url "http://$DOMAIN/web/" "200" "Offer page endpoint"

# Test with bot user agent (should get offer page)
if command -v curl >/dev/null 2>&1; then
    local bot_response=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 \
        -H "User-Agent: Googlebot/2.1" "http://$DOMAIN/" 2>/dev/null)
    if [ "$bot_response" = "302" ] || [ "$bot_response" = "200" ]; then
        print_status 0 "Bot detection working (HTTP $bot_response)"
    else
        print_status 1 "Bot detection may not be working (HTTP $bot_response)"
    fi
fi

# Test with human user agent (should get white page)
if command -v curl >/dev/null 2>&1; then
    local human_response=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" "http://$DOMAIN/" 2>/dev/null)
    if [ "$human_response" = "200" ]; then
        print_status 0 "Human traffic routing working (HTTP $human_response)"
    else
        print_status 1 "Human traffic routing may not be working (HTTP $human_response)"
    fi
fi

echo

# Log Files Check
print_header "Log Files"
check_file "/var/log/nginx/cloaking_access.log" "Nginx access log"
check_file "/var/log/nginx/cloaking_error.log" "Nginx error log"

# Check for recent errors
if [ -f "/var/log/nginx/cloaking_error.log" ]; then
    local recent_errors=$(tail -n 100 /var/log/nginx/cloaking_error.log 2>/dev/null | grep "$(date '+%Y/%m/%d')" | wc -l)
    if [ "$recent_errors" -eq 0 ]; then
        print_status 0 "No recent nginx errors today"
    else
        print_status 1 "$recent_errors nginx errors found today"
        if [ "$VERBOSE" = true ]; then
            echo -e "  ${YELLOW}Recent errors:${NC}"
            tail -n 5 /var/log/nginx/cloaking_error.log 2>/dev/null | sed 's/^/    /'
        fi
    fi
fi

# Check Next.js service logs
local nextjs_errors=$(journalctl -u nextjs-app --since "1 hour ago" --no-pager 2>/dev/null | grep -i error | wc -l)
if [ "$nextjs_errors" -eq 0 ]; then
    print_status 0 "No recent Next.js errors"
else
    print_status 1 "$nextjs_errors Next.js errors in the last hour"
    if [ "$VERBOSE" = true ]; then
        echo -e "  ${YELLOW}Recent Next.js errors:${NC}"
        journalctl -u nextjs-app --since "1 hour ago" --no-pager 2>/dev/null | grep -i error | tail -3 | sed 's/^/    /'
    fi
fi

echo

# Performance Check
print_header "Performance"

# Check system load
local load=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
if (( $(echo "$load < 2.0" | bc -l) )); then
    print_status 0 "System load is normal ($load)"
else
    print_status 1 "System load is high ($load)"
fi

# Check memory usage
local mem_usage=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')
if (( $(echo "$mem_usage < 80.0" | bc -l) )); then
    print_status 0 "Memory usage is normal (${mem_usage}%)"
else
    print_status 1 "Memory usage is high (${mem_usage}%)"
fi

# Check disk space
local disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$disk_usage" -lt 80 ]; then
    print_status 0 "Disk space is sufficient (${disk_usage}% used)"
else
    print_status 1 "Disk space is low (${disk_usage}% used)"
fi

echo

# Summary
print_header "Summary"
echo -e "Checks passed: ${GREEN}$CHECKS_PASSED${NC}/${CHECKS_TOTAL}"

if [ $OVERALL_STATUS -eq 0 ]; then
    echo -e "Overall status: ${GREEN}HEALTHY${NC}"
    echo -e "${GREEN}✓ All systems operational${NC}"
else
    echo -e "Overall status: ${RED}ISSUES DETECTED${NC}"
    echo -e "${YELLOW}⚠ Please review failed checks above${NC}"
fi

echo
echo -e "${BLUE}Useful commands:${NC}"
echo "  View logs: sudo tail -f /var/log/nginx/cloaking_access.log"
echo "  Restart services: sudo systemctl restart nginx nextjs-app php8.3-fpm"
echo "  Check service status: sudo systemctl status nextjs-app"
echo "  Run verbose check: ./healthcheck.sh --verbose"

exit $OVERALL_STATUS 