#!/usr/bin/env bash

# Test runner for rust-test-folding utility
# Uses plenary.nvim's test harness

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo -e "${YELLOW}Running Neovim tests...${NC}"
echo "Neovim config directory: $NVIM_DIR"
echo ""

# Check if nvim is available
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}Error: nvim is not installed or not in PATH${NC}"
    exit 1
fi

# Check if plenary is installed
if [ ! -d "$NVIM_DIR/lazy/plenary.nvim" ] && [ ! -d "$HOME/.local/share/nvim/lazy/plenary.nvim" ]; then
    echo -e "${YELLOW}Warning: plenary.nvim might not be installed${NC}"
    echo "Make sure plenary.nvim is available in your lazy.nvim plugins"
    echo ""
fi

# Run the tests using plenary
# The PlenaryBustedDirectory command runs all tests in the specified directory
nvim --headless \
    -u "$NVIM_DIR/init.lua" \
    -c "PlenaryBustedDirectory $SCRIPT_DIR { minimal_init = '$SCRIPT_DIR/minimal_init.lua' }" \
    -c "quitall!"

EXIT_CODE=$?

echo ""
if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
else
    echo -e "${RED}✗ Some tests failed${NC}"
fi

exit $EXIT_CODE
