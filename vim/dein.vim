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
  let s:toml = has('nvim')? s:rc_dir . '/nvim.toml': s:rc_dir . '/vim.toml'
  let s:lazy_toml = has('nvim')? s:rc_dir . '/nvim_lazy.toml': s:rc_dir . '/vim_lazy.toml'
  let s:common_toml = s:rc_dir . '/dein.toml'
  let s:common_lazy_toml = s:rc_dir . '/dein_lazy.toml'
  let s:ddu_toml = s:rc_dir . '/ddu.toml'

  call dein#load_toml(s:toml, #{ lazy: 0 })
  call dein#load_toml(s:lazy_toml, #{ lazy: 1 })
  call dein#load_toml(s:common_toml, #{ lazy: 0 })
  call dein#load_toml(s:common_lazy_toml, #{ lazy: 1 })
  call dein#load_toml(s:ddu_toml, #{ lazy: 1 })

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
