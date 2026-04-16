#!/bin/bash
set -e

echo "Linking configuration files..."

# Ensure target directories exist
mkdir -p ~/.config
mkdir -p ~/.vim

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
  ln -sfF ~/dotfiles/config/"$name" ~/.config/
done

# 3. Neovim/Vim internal structure (compatibility)
echo "Setting up Neovim/Vim internal links..."
ln -sfF ~/.config/nvim/autoload ~/.vim/
ln -sfF ~/.config/nvim/denops ~/.vim/
ln -sfF ~/.config/nvim/rc ~/.vim/
ln -sfF ~/.config/nvim/toml ~/.vim/
ln -sfF ~/.config/nvim/plugin ~/.vim/ 2>/dev/null || true

# 4. Zsh integration for Sheldon
if [ -f ~/.zshrc ]; then
  if ! grep -q "eval \"\$(sheldon source)\"" ~/.zshrc; then
    echo "Adding sheldon to .zshrc"
    echo "" >> ~/.zshrc
    echo 'eval "$(sheldon source)"' >> ~/.zshrc
  fi
fi

echo "Configuration linking completed!"
