#!/bin/bash
set -e

echo "Linking configuration files..."

# Ensure target directories exist
mkdir -p ~/.config
mkdir -p ~/.vim
mkdir -p ~/.proto

# 1. Link root dotfiles (individual files)
# Add any root-level dotfiles here
root_files=("vimrc" "tmux.conf")
for file in "${root_files[@]}"; do
  if [ -e "$file" ]; then
    echo "Linking ~/.$file"
    ln -sf ~/dotfiles/"$file" ~/."$file"
  fi
done

# 2. Link EVERYTHING inside config/ to ~/.config/ (Dynamic)
# This will handle nvim, wezterm, git, sheldon, etc.
for path in config/*; do
  name=$(basename "$path")
  echo "Linking ~/.config/$name"

  if [ -e ~/.config/"$name" ]; then
    echo "Skip ~/.config/$name already exists"
  else
    ln -s ~/dotfiles/config/"$name" ~/.config/
  fi
done

# 3. Neovim/Vim internal structure (compatibility)
echo "Setting up Neovim/Vim internal links..."
ln -sf ~/.config/nvim/autoload ~/.vim/
ln -sf ~/.config/nvim/denops ~/.vim/
ln -sf ~/.config/nvim/rc ~/.vim/
ln -sf ~/.config/nvim/toml ~/.vim/
ln -sf ~/.config/nvim/plugin ~/.vim/ 2>/dev/null || true

# 4. link proto config
echo "Setting up Neovim/Vim internal links..."
ln -sf ~/dotfiles/prototools ~/.proto/.prototools

# 5. Zsh integration for Sheldon
if [ -f ~/.zshrc ]; then
  if ! grep -q "eval \"\$(sheldon source)\"" ~/.zshrc; then
    echo "Adding sheldon to .zshrc"
    echo "" >> ~/.zshrc
    echo 'eval "$(sheldon source)"' >> ~/.zshrc
  fi
fi

echo "Configuration linking completed!"
