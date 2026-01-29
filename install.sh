#!/bin/bash
# reflect-yourself installer for Cursor

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "reflect-yourself installer"
echo "========================="
echo ""

# Detect OS
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    CURSOR_DIR="$USERPROFILE/.cursor"
else
    CURSOR_DIR="$HOME/.cursor"
fi

echo "Where would you like to install?"
echo ""
echo "1) Personal skill ($CURSOR_DIR/skills/reflect-yourself/)"
echo "   - Available in ALL your projects"
echo ""
echo "2) Current project (.cursor/)"
echo "   - Only for this project, can be committed to git"
echo ""
read -p "Choose [1/2]: " choice

case $choice in
    1)
        DEST="$CURSOR_DIR/skills/reflect-yourself"
        mkdir -p "$DEST/commands" "$DEST/rules"
        
        cp "$SCRIPT_DIR/SKILL.md" "$DEST/"
        cp "$SCRIPT_DIR/commands/"* "$DEST/commands/"
        cp "$SCRIPT_DIR/rules/"* "$DEST/rules/"
        cp "$SCRIPT_DIR/reflect-queue.json" "$DEST/"
        
        echo ""
        echo "✅ Installed to $DEST"
        echo ""
        echo "The skill is now available in all your Cursor projects."
        ;;
    2)
        if [ ! -d ".cursor" ]; then
            mkdir -p ".cursor"
        fi
        
        mkdir -p ".cursor/commands" ".cursor/rules"
        
        cp "$SCRIPT_DIR/commands/"* ".cursor/commands/"
        cp "$SCRIPT_DIR/rules/"* ".cursor/rules/"
        cp "$SCRIPT_DIR/reflect-queue.json" ".cursor/"
        
        echo ""
        echo "✅ Installed to .cursor/"
        echo ""
        echo "Commands and rules are now available in this project."
        echo ""
        echo "Consider adding to .gitignore:"
        echo "  .cursor/reflect-queue.json"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""
echo "Usage:"
echo "  /reflect-yourself        - Capture learnings from session"
echo "  /reflect-yourself-skills - Discover skill patterns"
echo "  /reflect-yourself-queue  - View pending learnings"
echo "  /reflect-yourself-skip   - Clear the queue"
echo ""
echo "Run /reflect-yourself at the end of your session!"
