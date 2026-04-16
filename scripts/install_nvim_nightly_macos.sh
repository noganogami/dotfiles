#!/bin/bash
set -e

echo "Updating Neovim nightly (macOS ARM64)..."
DIR=$(pwd)
INSTALL_DIR="$HOME/.local"
mkdir -p "$INSTALL_DIR/bin" "$INSTALL_DIR/share" "$INSTALL_DIR/lib"

cd "$INSTALL_DIR"
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
# Remove quarantine attribute (macOS specific)
xattr -c ./nvim-macos-arm64.tar.gz
tar xzvf nvim-macos-arm64.tar.gz

rsync -a ./nvim-macos-arm64/bin/* ./bin/
rsync -a ./nvim-macos-arm64/share/* ./share/
rsync -a ./nvim-macos-arm64/lib/* ./lib/

rm -f nvim-macos-arm64.tar.gz
rm -rf nvim-macos-arm64

echo "Neovim updated successfully in $INSTALL_DIR/bin/nvim"
cd "$DIR"
