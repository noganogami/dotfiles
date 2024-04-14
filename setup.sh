#!/bin/bash

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

files=("vimrc" "tmux.conf" "config/git" "config/nvim" "config/efm-langserver" "vim")
for file in "${files[@]}"
do
   if [ ! -f ~/.$file ];then
      ln -s ~/dotfiles/$file ~/.$file
   fi
done
