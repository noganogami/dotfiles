function! config#gin#init() abort
  augroup gin_settings
    autocmd!
    " 共通設定 (diff, log, status)
    autocmd FileType gin-diff,gin-log,gin-status call s:gin_common_settings()
    " status 専用設定
    autocmd FileType gin-status call s:gin_status_settings()
    " commit 専用設定
    autocmd FileType gin-commit call s:gin_commit_settings()
  augroup END
endfunction

function! s:gin_common_settings() abort
  nnoremap <buffer><silent> c <Cmd>Gin commit<CR>
  nnoremap <buffer><silent> s <Cmd>GinStatus<CR>
  nnoremap <buffer><silent> L <Cmd>GinLog --graph --oneline<CR>
  nnoremap <buffer><silent> d <Cmd>GinDiff --cached<CR>
  nnoremap <buffer><silent> q <Cmd>bdelete<CR>
  
  " 通知付きの push/pull
  nnoremap <buffer><silent> p <Cmd>lua vim.notify("Gin push")<CR><Cmd>Gin push<CR>
  nnoremap <buffer><silent> P <Cmd>lua vim.notify("Gin pull")<CR><Cmd>Gin pull<CR>
endfunction

function! s:gin_status_settings() abort
  " h で stage, l で unstage
  nmap <buffer><silent> h <Plug>(gin-action-stage)
  nmap <buffer><silent> l <Plug>(gin-action-unstage)
  " ビジュアルモードでも一括操作
  xmap <buffer><silent> h <Plug>(gin-action-stage)
  xmap <buffer><silent> l <Plug>(gin-action-unstage)
endfunction

function! s:gin_commit_settings() abort
  nnoremap <buffer><silent> <leader>a <Cmd>Apply<CR>
endfunction
