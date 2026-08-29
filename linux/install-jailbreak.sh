#!/bin/bash
# OpenCode Jailbreak Agent Installer - Linux/macOS
# Downloads latest jailbreak.md from GitHub

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO="Sunny-son-sahur/opencode-jailbreak"
BRANCH="main"
RAW_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/linux/jailbreak.md"

echo -e "${YELLOW}OpenCode Jailbreak Agent Installer${NC}"
echo ""

# Detect OpenCode config directory
OPENCODE_DIR=""
if [ -d "$HOME/.config/opencode" ]; then
    OPENCODE_DIR="$HOME/.config/opencode"
elif [ -d "$HOME/.opencode" ]; then
    OPENCODE_DIR="$HOME/.opencode"
else
    echo -e "${RED}Error: OpenCode config directory not found${NC}"
    exit 1
fi

echo "Found OpenCode config at: $OPENCODE_DIR"

AGENTS_DIR="$OPENCODE_DIR/agents"
mkdir -p "$AGENTS_DIR"

# Download from GitHub
echo "Downloading latest jailbreak.md..."
if curl -sL "$RAW_URL" -o "$AGENTS_DIR/jailbreak.md"; then
    if [ -f "$AGENTS_DIR/jailbreak.md" ] && grep -q "morgan" "$AGENTS_DIR/jailbreak.md" 2>/dev/null; then
        echo -e "${GREEN}Installed and updated!${NC}"
    else
        echo -e "${RED}Download failed - file empty or invalid${NC}"
        exit 1
    fi
else
    echo -e "${RED}Failed to download from GitHub${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}Done! Restart OpenCode.${NC}"
echo "  Desktop:  Press Ctrl+. to switch to jailbreak"
echo "  Console:  opencode --agent jailbreak"
echo ""
