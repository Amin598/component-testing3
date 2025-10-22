#!/bin/bash

# Shopify theme test cleanup script
# Kills all shopify theme dev servers and optionally removes theme directories

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Shopify Theme Test Cleanup ===${NC}"

# Find and kill all shopify theme dev processes on ports 9100-9199
echo -e "${YELLOW}Searching for shopify theme dev servers on ports 9100-9199...${NC}"

# Get all shopify theme dev processes
PIDS=$(ps aux | grep "shopify theme dev" | grep -E "port=(9[0-1][0-9]{2})" | grep -v grep | awk '{print $2}')

if [ -z "$PIDS" ]; then
    echo -e "${GREEN}No shopify theme dev servers found on ports 9100-9199${NC}"
else
    echo -e "${YELLOW}Found servers with PIDs: ${PIDS}${NC}"
    echo -e "${RED}Killing servers...${NC}"
    kill $PIDS 2>/dev/null
    sleep 2
    # Force kill if still running
    kill -9 $PIDS 2>/dev/null
    echo -e "${GREEN}All servers stopped${NC}"
fi

# Ask if user wants to remove theme directories
read -p "Do you want to remove all theme directories in shopify-theme-test/? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Removing theme directories...${NC}"
    rm -rf shopify-theme-test/
    echo -e "${GREEN}Theme directories removed${NC}"
else
    echo -e "${BLUE}Theme directories kept${NC}"
fi

echo -e "${GREEN}Cleanup complete!${NC}"
