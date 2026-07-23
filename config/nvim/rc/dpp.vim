" dpp.vim Scripts-----------------------------
let s:default_runtimepath = &runtimepath

if &compatible
  set nocompatible
endif

let s:dpp_dir = expand('~/.cache/dpp')
if !isdirectory(s:dpp_dir)
  call mkdir(s:dpp_dir, 'p')
endif

" automatic installation of dpp and dependencies
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

function! s:dpp_ready() abort
  " 状態ロード後または生成後に実行
  let l:not_installed = dpp#sync_ext_action('installer', 'getNotInstalled')
  if !empty(l:not_installed)
    echomsg 'dpp: installing missing plugins...'
    call dpp#async_ext_action('installer', 'install')
    return
  endif

  " ddu 初期化の呼び出し (関数が存在すれば呼び出す)
  try
    call config#ddu#init()
    echomsg 'dpp: ddu initialized.'
  catch /^Vim\%((\a\+)\)\=:E117: Unknown function: config#ddu#init$/
    echomsg 'dpp: ddu is not ready yet (config#ddu#init not found).'
  catch
    echomsg 'dpp: error during ddu initialization: ' . v:exception
  endtry
endfunction

if dpp#min#load_state(s:dpp_dir)
  " 状態がない(ロード失敗)場合、DenopsReady 時に状態を生成
  autocmd User DenopsReady
  \ echomsg 'dpp: making state...' |
  \ call dpp#make_state(s:dpp_dir, s:dpp_config_path)
else
  " 状態がある(ロード成功)場合、DenopsReady 時に dpp_ready を呼び出し
  autocmd User DenopsReady call s:dpp_ready()
endif

" dpp の state に古い Neovim のパスが保存されていても、現在実行中の
" Neovim が起動時に設定した runtime（標準 ftplugin や parser を含む）を保つ。
for s:path in split(s:default_runtimepath, ',')
  if index(split(&runtimepath, ','), s:path) < 0
    execute 'set runtimepath+=' . fnameescape(s:path)
  endif
endfor

" 状態生成完了後の処理
autocmd User Dpp:makeStatePost call s:dpp_ready()
autocmd User Dpp:extActionPost:installer:install call s:dpp_ready()

" Commands
command! DppInstall call dpp#async_ext_action('installer', 'install')
command! DppUpdate call dpp#async_ext_action('installer', 'update')
command! DppCache call system('deno cache ' . s:dpp_config_path)
execute 'command! DppMakeState call dpp#make_state("' . s:dpp_dir . '", "' . s:dpp_config_path . '")'

"End dpp.vim Scripts-------------------------
