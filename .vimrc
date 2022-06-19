"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('tpope/vim-surround')
call dein#add('previm/previm')

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


"previm settings
let g:previm_open_cmd = '/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
let g:previm_wsl_mode = 1


set autoindent

set number

syntax on

set clipboard+=unnamed

set tabstop=4
set shiftwidth=3
set expandtab

set wildmenu
set history=5000

set list
set listchars=tab:>-

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
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap \" \"\"<Left>
"inoremap ' ''<Left>
"inoremap { {}<Left>

cnoremap py !python %
