vim.cmd [[
  let g:Illuminate_useDeprecated = 1
  let g:Illuminate_ftwhitelist = ['python, c, php']
]]

-- require('illuminate').configure({
--   -- overrides allowlist
--   -- filetypes_denylist = {'all'},
--   filetypes_allowlist = {'c'},
-- })

-- require'lspconfig'.jedi_language_server.setup {
--   on_attach = function(client)
--     require 'illuminate'.on_attach(client)
--   end,
-- }

-- require'lspconfig'.clangd.setup {
--   on_attach = function(client)
--     require 'illuminate'.on_attach(client)
--   end,
-- }

-- -- require'lspconfig'.phpactor.setup{
-- --   on_attach = function(client)
-- --     require 'illuminate'.on_attach(client)
-- --   end,
-- --   root_dir = function(fname)
-- --       return require 'lspconfig'.util.root_pattern("composer.json", ".git", ".root")(fname) or vim.fn.getcwd()
-- --   end,
-- -- }

-- vim.api.nvim_command [[hi def link LspReferenceText CursorLine]]
-- vim.api.nvim_command [[hi def link LspReferenceWrite CursorLine]]
-- vim.api.nvim_command [[hi def link LspReferenceRead CursorLine]]
