#!/bin/bash

files=(".vimrc" ".tmux.conf" ".config/git")
for file in "${files[@]}"
do
   if [ ! -e ~/$file ];then
      ln -s ~/dotfiles/$file ~/$file
   fi
done
