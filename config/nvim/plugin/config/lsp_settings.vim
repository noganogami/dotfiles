function! config#lsp_settings#init()
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_settings = {
      \   'pylsp-all': {
      \     'workspace_config': {
      \       'pylsp': {
      \         'configurationSources': ['flake8'],
      \         'plugins': {
      \           'autopep8': {
      \             'enabled': 0
      \           },
      \           'black': {
      \             'enabled': 1,
      \             'preview': 0
      \           },
      \           'flake8': {
      \             'enabled': 1,
      \             'maxLineLength': 88
      \           },
      \           'mccabe': {
      \             'enabled': 0
      \           },
      \           'pycodestyle': {
      \             'enabled': 0
      \           },
      \           'pyflakes': {
      \             'enabled': 0
      \           },
      \           'pyls_isort': {
      \             'enabled': 1
      \           },
      \           'pylsp_mypy': {
      \             'enabled': 1
      \           },
      \           'yapf': {
      \             'enabled': 0
      \           }
      \         }
      \       }
      \     }
      \   },
      \  'deno': {
      \    'disabled': 1
      \  },
      \   'efm-langserver': {
      \     'disabled': v:false
      \   },
      \ }
endfunction
