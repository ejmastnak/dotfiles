-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4
vim.wo.foldmethod  = 'indent'
vim.wo.foldlevel   = 99

vim.keymap.set('', '<Leader>r', '<Cmd>update<CR><Cmd>TermExec size=8 cmd="python3 %"<CR>')

-- Source Jedi language server config
require('lsp.jedi-server')
