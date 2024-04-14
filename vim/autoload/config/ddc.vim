function! config#ddc#init()
  call popup_preview#enable()

  call ddc#custom#patch_global({
      \   'ui': 'pum',
      \   'sources': ['vim-lsp','around'],
      \   'sourceOptions': {
      \     '_': {
      \       'matchers': ['matcher_fuzzy'],
      \       'sorters': ['sorter_fuzzy'],
      \       'converters': ['converter_fuzzy', 'converter_remove_overlap'],
      \       'ignoreCase': v:true,
      \     },
      \     'vim-lsp': {
      \       'mark': 'Vim-LSP',
      \       'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \     },
      \     'lsp': {
      \       'mark': 'LSP',
      \       'dup': 'keep',
      \       'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \       'keywordPattern': '\k+',
      \     },
      \     'around': {
      \       'mark': 'around',
      \     },
      \     'buffer': {
      \       'mark': 'buffer',
      \     },
      \   },
      \   'filterParams': {
      \     'matcher_fuzzy': {
      \       'splitMode': 'character',
      \     },
      \   },
      \ })

  call ddc#enable()
endfunction
