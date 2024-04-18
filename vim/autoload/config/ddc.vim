function! config#ddc#init()
  call popup_preview#enable()

  call ddc#custom#patch_global({
      \   'ui': 'pum',
      \   'sources': ['lsp', 'vim-lsp', 'around', 'buffer'],
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
      \       'sorters': ['sorter_lsp-kind'],
      \     },
      \     'lsp': {
      \       'mark': 'LSP',
      \       'dup': 'keep',
      \       'keywordPattern': '\k+',
      \     },
      \     'around': {
      \       'mark': 'around',
      \     },
      \     'buffer': {
      \       'mark': 'buffer',
      \     },
      \   },
      \   'sourceParams': {
      \     'lsp': {
      \       'enableResolveItem': v:true,
      \       'enableAdditionalTextEdit': v:true,
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
