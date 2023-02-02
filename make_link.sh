#!/bin/bash

files=(".vimrc" ".tmux.conf" ".gitconfig" ".gitignore_global")
for file in "${files[@]}"
do
   if [ ! -e ~/$file ];then
      ln -s ~/dotfiles/$file ~/$file
   fi
done
