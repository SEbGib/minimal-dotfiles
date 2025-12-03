#!/bin/bash

# ===== Docker Test Environment Runner =====
# Script to build and run the Ubuntu Docker test environment

set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

IMAGE_NAME="dotfiles-ubuntu-test"
CONTAINER_NAME="dotfiles-test-$(date +%s)"

echo -e "${BLUE}🐳 Building Docker test environment...${NC}"

# Build the Docker image
if docker build -f test-ubuntu.Dockerfile -t "$IMAGE_NAME" .; then
    echo -e "${GREEN}✅ Docker image built successfully${NC}"
else
    echo "❌ Failed to build Docker image"
    exit 1
fi

echo ""
echo -e "${BLUE}🚀 Running dotfiles tests in Ubuntu container...${NC}"

# Run the container
if docker run --rm --name "$CONTAINER_NAME" "$IMAGE_NAME"; then
    echo ""
    echo -e "${GREEN}✅ Tests completed successfully!${NC}"
    exit 0
else
    echo ""
    echo -e "${YELLOW}⚠️  Tests completed with issues. Check output above.${NC}"
    exit 1
fi