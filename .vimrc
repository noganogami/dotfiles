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
call dein#add('tpope/vim-repeat')

call dein#add('previm/previm')

call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('prabirshrestha/asyncomplete.vim')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')

call dein#add('rhysd/vim-clang-format')
call dein#add('kana/vim-operator-user')

call dein#add('nvie/vim-flake8')

call dein#add('maxmellon/vim-jsx-pretty')

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


let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server', 'deno']


"previm settings-------------------------
if system('uname') =~ 'Darwin'
    "mac
    let g:previm_open_cmd = 'open -a Google\ Chrome'
elseif isdirectory('/mnt/c')
    "wsl
    let g:previm_open_cmd = '/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
    let g:previm_wsl_mode = 1
endif 
"-------------------------


" asyncomplete-------------------------
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" allow modifying the completeopt variable, or it will
" be overridden all the time
let g:asyncomplete_auto_completeopt = 0

set completeopt=menuone,noinsert,noselect,preview
"-------------------------


"format-------------------------
autocmd FileType c,cpp ClangFormatAutoEnable

function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    "--ignote=E501: Ignore completing the length of a line."
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction

function! Pretty_jsx()
    call Preserve(':normal ggVG=')
endfunction

augroup auto_format
  autocmd!
  autocmd BufWrite *.py :call Autopep8()
  autocmd BufWrite *.py :call Flake8()
  autocmd BufWrite *.js,*.jsx :call Pretty_jsx()
augroup END

"-------------------------


set autoindent

set number

syntax on

set confirm

set clipboard=unnamed

set tabstop=4
set shiftwidth=2
set expandtab

set wildmenu
set history=5000

set list
set listchars=tab:>-

set hlsearch
"set incsearch
set ignorecase
set smartcase
hi Search ctermbg=Cyan
hi Search ctermfg=White

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk


"inoremap <silent> jj <ESC>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

inoremap {<Enter> {<CR>}<Left><CR><Up><C-t>
"inoremap :<Enter> :<CR><Tab>
"inoremap (<Enter> (<CR>)<Left><CR><Up><C-t>
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap \" \"\"<Left>
"inoremap ' ''<Left>
"inoremap { {}<Left>

"cnoremap py !python %

"repeat.vim 
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
