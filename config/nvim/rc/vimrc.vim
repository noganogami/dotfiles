set autoindent
set number
set confirm
set clipboard=unnamed
set cursorline

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd! BufNewFile,BufRead *.vim,*.ts,*.tsx,*.js,*.vue setlocal tabstop=2 shiftwidth=2 softtabstop=2

set wildmenu
set history=5000

set list
set listchars=tab:>-

set hlsearch
set ignorecase
set smartcase

nnoremap [b <Cmd>bprev<CR>
nnoremap ]b <Cmd>bnext<CR>

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

cnoremap <C-a> <Home>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-b> <Space><BS><Left>
cnoremap <C-f> <Space><BS><Right>

let mapleader = "\<Space>"

autocmd! TextYankPost * :call yankukku#Yank()
execute 'source' $"{'<sfile>'->expand()->fnamemodify(':h')}/dein.vim"

filetype plugin indent on
syntax enable
