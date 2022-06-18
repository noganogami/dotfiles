"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/$HOME/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('tpope/vim-surround')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


set autoindent

set number

syntax on

set clipboard+=unnamed

set tabstop=4
set shiftwidth=2
set expandtab

set hlsearch
set incsearch
set ignorecase
set smartcase

inoremap <silent> jj <ESC>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

inoremap {<Enter> {<CR>}<Left><CR><Up><C-t>
inoremap :<Enter> :<CR><Tab>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap { {}<Left>

cnoremap py !python %
