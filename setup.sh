#!/bin/bash

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

files=("vimrc" "tmux.conf" "config/git" "config/nvim" "config/efm-langserver" "vim")
for file in "${files[@]}"
do
   if [ ! -e ~/.$file ];then
      ln -s ~/dotfiles/$file ~/.$file
   fi
done

ln -s ~/.vim/autoload ~/.config/nvim/autoload
ln -s ~/.vim/denops ~/.config/nvim/denops
