"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" automatic instrallation of dein
if !isdirectory(s:dein_dir)
  call mkdir(s:dein_dir, 'p')
endif
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" load plugin configration
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:rc_dir = expand('~/.vim')
  let s:toml = s:rc_dir . '/dein.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, #{ lazy: 0 })
  call dein#load_toml(s:lazy_toml, #{ lazy: 1 })

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
colorscheme lucius

" automatically install not installed plugins.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set autoindent
set number
set confirm
set clipboard=unnamed
set cursorline

set tabstop=4
set shiftwidth=2
set expandtab

set wildmenu
set history=5000

set list
set listchars=tab:>-

set hlsearch
set ignorecase
set smartcase
"hi Search ctermbg=Cyan
"hi Search ctermfg=White

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
