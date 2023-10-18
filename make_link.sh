#!/bin/bash

if [ ! -d "~/.config" ]; then
  mkdir ~/.config
fi

files=(".vimrc" ".tmux.conf" ".config/git" ".config/efm-langserver" ".vim")
for file in "${files[@]}"
do
   if [ ! -e ~/$file ];then
      ln -s ~/dotfiles/$file ~/$file
   fi
done
