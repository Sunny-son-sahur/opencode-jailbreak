#!/bin/bash
# OpenCode Jailbreak Agent Installer - Linux/macOS
# Downloads latest jailbreak.md from GitHub to BOTH locations

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

# Create both directories
DIR1="$HOME/.config/opencode/agents"
DIR2="$HOME/.opencode/agents"
mkdir -p "$DIR1" "$DIR2"

# Download from GitHub
echo "Downloading latest jailbreak.md..."
TMPFILE=$(mktemp)
if curl -sL "$RAW_URL" -o "$TMPFILE"; then
    if [ -f "$TMPFILE" ] && grep -q "morgan" "$TMPFILE" 2>/dev/null; then
        echo -e "${GREEN}Download verified!${NC}"
    else
        echo -e "${RED}Download failed - file empty or invalid${NC}"
        rm -f "$TMPFILE"
        exit 1
    fi
else
    echo -e "${RED}Failed to download from GitHub${NC}"
    rm -f "$TMPFILE"
    exit 1
fi

# Install to both locations
echo "Installing to $DIR1 ..."
cp "$TMPFILE" "$DIR1/jailbreak.md"

echo "Installing to $DIR2 ..."
cp "$TMPFILE" "$DIR2/jailbreak.md"

rm -f "$TMPFILE"

echo ""
echo -e "${GREEN}Done! Installed to both locations:${NC}"
echo "  $DIR1/jailbreak.md"
echo "  $DIR2/jailbreak.md"
echo ""
echo "Restart OpenCode to load the update."
echo "  Desktop:  Press Ctrl+. to switch to jailbreak"
echo "  Console:  opencode --agent jailbreak"
echo ""
