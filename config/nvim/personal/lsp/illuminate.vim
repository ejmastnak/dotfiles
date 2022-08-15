let g:Illuminate_ftwhitelist = ['python, c']
lua <<EOF
  require'lspconfig'.jedi_language_server.setup {
    on_attach = function(client)
      require 'illuminate'.on_attach(client)
    end,
  }
  require'lspconfig'.clangd.setup {
    on_attach = function(client)
      require 'illuminate'.on_attach(client)
    end,
  }
  require'lspconfig'.phpactor.setup{
    on_attach = function(client)
      require 'illuminate'.on_attach(client)
    end,
    root_dir = function(fname)
        return require 'lspconfig'.util.root_pattern("composer.json", ".git", ".root")(fname) or vim.fn.getcwd()
    end,
  }

vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]
EOF
" highlight link illuminatedWord Visual
