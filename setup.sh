#!/bin/bash

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

if [ ! -d ~/.config/alacritty/themes ]; then
  mkdir -p ~/.config/alacritty/themes
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi

files=("vimrc" "tmux.conf" "config/git" "config/nvim" "config/alacritty/alacritty.toml" "config/efm-langserver" "vim")
for file in "${files[@]}"
do
   if [ ! -e ~/.$file ];then
      ln -s ~/dotfiles/$file ~/.$file
   fi
done

if [ ! -e ~/.config ]; then
  ln -s ~/.vim/autoload ~/.config/nvim/autoload
  ln -s ~/.vim/denops ~/.config/nvim/denops
fi
