let g:Illuminate_ftwhitelist = ['python']
lua <<EOF
  require'lspconfig'.jedi_language_server.setup {
    on_attach = function(client)
      require 'illuminate'.on_attach(client)
    end,
  }
vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]
EOF
" highlight link illuminatedWord Visual
