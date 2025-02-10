#!/bin/bash

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

if [ $TERM = "alacritty" ]; then
  if [ ! -d ~/.config/alacritty/ ]; then
    mkdir ~/.config/alacritty
    ln -s config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
  fi

  if [ ! -d ~/.config/alacritty/themes ]; then
    mkdir ~/.config/alacritty/themes
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
  fi
fi

files=("vimrc" "tmux.conf" "config/git" "config/nvim" "config/wezterm" "config/sheldon")
# files=("vimrc" "tmux.conf" "config/git" "config/nvim" "config/wezterm" "config/sheldon" "config/efm-langserver" "vim")
for file in "${files[@]}"
do
  if [ ! -e ~/.$file ];then
     ln -s ~/dotfiles/$file ~/.$file
  fi
done

if [ ! -e ~/.vim/ ]; then
  mkdir ~/.vim
fi
ln -s ~/.config/nvim/autoload ~/.vim/autoload
ln -s ~/.config/nvim/denops ~/.vim/denops
ln -s ~/.config/nvim/rc ~/.vim/rc
ln -s ~/.config/nvim/toml ~/.vim/toml
ln -s ~/.config/nvim/plugin ~/.vim/plugin

if [ -f ~/.zshrc ] && ! grep -q "eval \"\$(sheldon source)\"" ~/.zshrc; then
  echo "" >> ~/.zshrc
  echo 'eval "$(sheldon source)"' >> ~/.zshrc
fi
