#!/bin/bash
set -e

# Detect OS
OS=$(uname -s)
ARCH=$(uname -m)

echo "Starting initial installation for $OS ($ARCH)..."

# macOS specific initial setup
if [ "$OS" = "Darwin" ]; then
  # Install Homebrew if not exists
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Path setup for the current session
    if [ "$ARCH" = "arm64" ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    echo "Homebrew already installed. Updating..."
    brew update
  fi

  # Ensure just is installed
  if ! command -v just &> /dev/null; then
    echo "Installing just..."
    brew install just
  fi
  
  # Delegate rest to just
  echo "Delegating setup to just..."
  just sync
else
  echo "Detected Linux. Basic setup..."
  mkdir -p ~/.config
  # Linux setup can be added here
fi

echo "Installation process finished!"
