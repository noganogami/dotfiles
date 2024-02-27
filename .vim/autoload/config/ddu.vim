function! s:ddu_ui_default_settings() abort
  call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'uiParams': {
      \     'ff': {
      \       'startAutoAction': v:true,
      \       'autoAction': {'name': 'preview'},
      \       'previewFloating': v:true,
      \     }
      \   },
      \   'sourceOptions': {
      \     '_': {
      \       'matchers': ['matcher_substring'],
      \       'ignoreCase': v:true,
      \     },
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \     'word': {
      \       'defaultAction': 'append',
      \     },
      \   }
      \ })

  call ddu#custom#patch_local('filer', {
      \   'ui': 'filer',
      \   'sources': [
      \     {
      \       'name': 'file',
      \       'params': {
      \         'ignoredDirectories': ['.git', '.mypy_cache', '__pycache__', 'bin']
      \       }
      \     }
      \   ],
      \   'sourceOptions': {
      \     '_': {
      \       'columns': ['icon_filename'],
      \       'matchers': ['matcher_hidden'],
      \       'sorters': ['sorter_alpha'],
      \     },
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \   }
      \ })
endfunction

function! s:ddu_ff_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> o
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#ff#do_action('togglePreview')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'insert'})<CR>
  nnoremap <buffer><silent> t
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'tabe'}})<CR>
  nnoremap <buffer><silent> s
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'split'}})<CR>
  nnoremap <buffer><silent> v
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': {'command': 'vsplit'}})<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> >
        \ <Cmd>call ddu#ui#ff#do_action('updateOptions', {
        \   'sourceOptions': {
        \     '_': {
        \       'matchers': config#ddu#toggleHidden(),
        \     },
        \   },
        \ })<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

function! s:ddu_filter_settings() abort
  inoremap <buffer><silent> <CR>
        \ <Esc><Cmd>call ddu#ui#ff#do_action('closeFilterWindow')<CR>
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('closeFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('closeFilterWindow')<CR>
endfunction

function! s:ddu_filer_settings() abort
  nnoremap <buffer><silent><expr> <CR>
        \ ddu#ui#get_item()->get('isTree', v:false) ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction')<CR>"
  nnoremap <buffer><silent><expr> o
        \ ddu#ui#get_item()->get('isTree', v:false) ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction')<CR>"
  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#ff#do_action('togglePreview')<CR>
  nnoremap <buffer><silent><expr> t
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'params': {'command': 'tabe'}})<CR>"
  nnoremap <buffer><silent><expr> s
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'params': {'command': 'split'}})<CR>"
  nnoremap <buffer><silent><expr> v
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'params': {'command': 'vsplit'}})<CR>"
  nnoremap <buffer><silent> n
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newFile'})<CR>
  nnoremap <buffer><silent> m
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newDirectory'})<CR>
  nnoremap <buffer><silent> d
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'delete'})<CR>
  nnoremap <buffer><silent> r
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'rename'})<CR>
  nnoremap <buffer><silent> ..
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>
  nnoremap <buffer><silent> >
        \ <Cmd>call ddu#ui#filer#do_action('updateOptions', {
        \   'sourceOptions': {
        \     '_': {
        \       'matchers': config#ddu#toggleHidden(),
        \     },
        \   },
        \ })<CR>
  nnoremap <buffer><silent> q
        \  <Cmd>call ddu#ui#filer#do_action('quit')<CR>
endfunction

function! config#ddu#toggleHidden()
  let current = ddu#custom#get_current(b:ddu_ui_name)
  let source_options = get(current, 'sourceOptions', {})
  let source_options_all = get(source_options, '_', {})
  let matchers = get(source_options_all, 'matchers', [])
  let matcher_idx = index(matchers, 'matcher_hidden')

  if matcher_idx >= 0
    call remove(matchers, matcher_idx)
  else
    call add(matchers, 'matcher_hidden')
  endif
  return matchers
endfunction

function! s:key_mapping()
  nnoremap <silent> ;f
      \ <Cmd>call ddu#start({
      \   'uiParams': {
      \     'ff': {
      \       'startFilter': v:false
      \     }
      \   },
      \   'sources': [
      \     {
      \       'name': 'file_rec',
      \       'params': {
      \         'ignoredDirectories': ['.cache', '.git', '.mypy_cache', '__pycache__', 'bin', '.npm', 'node_modules', 'go', 'deno']
      \       }
      \     }
      \   ],
      \ })<CR>
  nnoremap <silent> ;b
      \ <Cmd>call ddu#start({'sources': [{'name': 'buffer'}]})<CR>
  nnoremap <silent> ;r
      \ <Cmd>call ddu#start({
      \   'uiParams': {
      \     'ff': {
      \       'startAutoAction': v:false,
      \     }
      \   },
      \   'sources': [{'name': 'register'}],
      \   'sourceOptions': {
      \     '_': {
      \       'converters': ['filter_prefix'],
      \     },
      \   },
      \ })<CR>
  nnoremap <silent> ;m
      \ <Cmd>call ddu#start({'sources': [{'name': 'mr'}]})<CR>
  nnoremap <silent> ;t
      \ <Cmd>call ddu#start({'name': 'filer'})<CR>
endfunction

function! config#ddu#init()
  call s:ddu_ui_default_settings()
  call s:key_mapping()

  autocmd FileType ddu-ff call s:ddu_ff_settings()
  autocmd FileType ddu-ff-filter call s:ddu_filter_settings()

  autocmd FileType ddu-filer call s:ddu_filer_settings()
endfunction
