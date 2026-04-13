" dpp.vim Scripts-----------------------------
if &compatible
  set nocompatible
endif

let s:dpp_dir = expand('~/.cache/dpp')
let s:dpp_repo_dir = s:dpp_dir . '/repos/github.com/Shougo/dpp.vim'
let s:denops_repo_dir = s:dpp_dir . '/repos/github.com/vim-denops/denops.vim'

" protocols
let s:dpp_protocol_git_dir = s:dpp_dir . '/repos/github.com/Shougo/dpp-protocol-git'

" extensions
let s:dpp_ext_installer_dir = s:dpp_dir . '/repos/github.com/Shougo/dpp-ext-installer'
let s:dpp_ext_toml_dir = s:dpp_dir . '/repos/github.com/Shougo/dpp-ext-toml'
let s:dpp_ext_lazy_dir = s:dpp_dir . '/repos/github.com/Shougo/dpp-ext-lazy'

" automatic installation of dpp and dependencies
if !isdirectory(s:dpp_dir)
  call mkdir(s:dpp_dir, 'p')
endif

function! s:clone(repo)
  let l:dir = s:dpp_dir . '/repos/github.com/' . a:repo
  if !isdirectory(l:dir)
    execute '!git clone https://github.com/' . a:repo l:dir
  endif
  execute 'set runtimepath^=' . l:dir
endfunction

call s:clone('vim-denops/denops.vim')
call s:clone('Shougo/dpp.vim')
call s:clone('Shougo/dpp-protocol-git')
call s:clone('Shougo/dpp-ext-installer')
call s:clone('Shougo/dpp-ext-toml')
call s:clone('Shougo/dpp-ext-lazy')

" dpp config
let s:dpp_config_path = expand('<sfile>:h:h') . '/dpp/config.ts'

if dpp#min#load_state(s:dpp_dir)
  autocmd User DenopsReady
  \ call dpp#make_state(s:dpp_dir, s:dpp_config_path)
endif

" Commands
command! DppInstall call dpp#async_ext_action('installer', 'install')
command! DppUpdate call dpp#async_ext_action('installer', 'update')

"End dpp.vim Scripts-------------------------
