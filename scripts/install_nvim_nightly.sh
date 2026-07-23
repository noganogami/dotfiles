#!/bin/bash
set -eu

OS=$(uname -s)
ARCH=$(uname -m)

case "$OS:$ARCH" in
  Darwin:arm64)
    PACKAGE="nvim-macos-arm64"
    ;;
  Darwin:x86_64)
    PACKAGE="nvim-macos-x86_64"
    ;;
  Linux:x86_64|Linux:amd64)
    PACKAGE="nvim-linux-x86_64"
    ;;
  Linux:arm64|Linux:aarch64)
    PACKAGE="nvim-linux-arm64"
    ;;
  *)
    echo "Unsupported platform: $OS ($ARCH)" >&2
    exit 1
    ;;
esac

INSTALL_DIR="${NVIM_INSTALL_DIR:-$HOME/.local}"
ARCHIVE="$PACKAGE.tar.gz"
URL="https://github.com/neovim/neovim/releases/download/nightly/$ARCHIVE"
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

echo "Updating Neovim nightly for $OS ($ARCH)..."
curl -fL "$URL" -o "$TEMP_DIR/$ARCHIVE"

if [ "$OS" = "Darwin" ] && command -v xattr >/dev/null 2>&1; then
  xattr -c "$TEMP_DIR/$ARCHIVE"
fi

tar -xzf "$TEMP_DIR/$ARCHIVE" -C "$TEMP_DIR"

if [ ! -x "$TEMP_DIR/$PACKAGE/bin/nvim" ]; then
  echo "Downloaded archive does not contain an executable nvim binary." >&2
  exit 1
fi

mkdir -p "$INSTALL_DIR"
rsync -a "$TEMP_DIR/$PACKAGE/" "$INSTALL_DIR/"

echo "Neovim updated successfully in $INSTALL_DIR/bin/nvim"
