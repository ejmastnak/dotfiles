require('lspconfig').phpactor.setup {
  cmd = {"phpactor", "language-server"},
  filetypes = {"php"},
  root_dir = require("lspconfig/util").root_pattern("composer.json", ".git"),
  on_attach = function()
    vim.diagnostic.disable(0)
    require('illuminate').on_attach(client)
  end
}

require('lspconfig').jedi_language_server.setup {
  on_attach = function(client)
    vim.diagnostic.disable(0)
    require('illuminate').on_attach(client)
  end,
}

require('lspconfig').clangd.setup {
  on_attach = function(client)
    require('illuminate').on_attach(client)
  end,
}

-- require('jdtls').start_or_attach({
--     cmd = {'/home/ej/.local/bin/jdtls'},
--     root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', '.root'}, { upward = true })[1]),
--   on_attach = function(client)
--     vim.diagnostic.disable(0)
--     require('illuminate').on_attach(client)
--   end,
-- })

-- require('lspconfig').sumneko_lua.setup {
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--         -- version = 'Lua 5.1',
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
--   on_attach = function(client)
--     vim.diagnostic.disable(0)
--     require('illuminate').on_attach(client)
--   end,
-- }
