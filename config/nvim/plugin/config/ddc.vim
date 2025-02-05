function! config#ddc#init()
  call popup_preview#enable()

  call ddc#custom#patch_global({
      \   'ui': 'pum',
      \   'sources': ['lsp', 'skkeleton', 'around', 'buffer'],
      \   'sourceOptions': {
      \     '_': {
      \       'matchers': ['matcher_fuzzy'],
      \       'sorters': ['sorter_fuzzy'],
      \       'converters': ['converter_fuzzy', 'converter_remove_overlap'],
      \       'ignoreCase': v:true,
      \     },
      \     'lsp': {
      \       'mark': 'LSP',
      \       'dup': 'keep',
      \       'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \       'keywordPattern': '\k+',
      \     },
      \     'skkeleton': {
      \       'mark': 'Skkeleton',
      \       'matchers': [],
      \       'sorters': [],
      \       'converters': [],
      \       'isVolatile': v:true,
      \       'minAutoCompleteLength': 1,
      \     },
      \     'around': {
      \       'mark': 'Around',
      \     },
      \     'buffer': {
      \       'mark': 'Buffer',
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
