require('lspconfig').phpactor.setup {
  cmd = {"phpactor", "language-server"},
  filetypes = {"php"},
  root_dir = require("lspconfig/util").root_pattern("composer.json", ".git"),
  on_attach = function()
    require('illuminate').on_attach(client)
    vim.diagnostic.disable(0)
  end
}

require('lspconfig').jedi_language_server.setup {
  on_attach = function(client)
    require('illuminate').on_attach(client)
  end,
}

require('lspconfig').clangd.setup {
  on_attach = function(client)
    require('illuminate').on_attach(client)
  end,
}

require('lspconfig').gopls.setup {
  on_attach = function(client)
    require('illuminate').on_attach(client)
  end,
}

require'lspconfig'.jdtls.setup{
  on_attach = function(client)
    require('illuminate').on_attach(client)
  end,
}
