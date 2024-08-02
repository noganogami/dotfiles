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

files=("vimrc" "tmux.conf" "config/git" "config/nvim" "config/sheldon" "config/efm-langserver" "vim")
for file in "${files[@]}"
do
   if [ ! -e ~/.$file ];then
      ln -s ~/dotfiles/$file ~/.$file
   fi
done

if [ ! -e ~/.config/nvim ]; then
  ln -s ~/.vim/autoload ~/.config/nvim/autoload
  ln -s ~/.vim/denops ~/.config/nvim/denops
fi

if [ -f ~/.zshrc ] && ! grep -q "eval \"\$(sheldon source)\"" ~/.zshrc; then
    echo "" >> ~/.zshrc
    echo 'eval "$(sheldon source)"' >> ~/.zshrc
fi
