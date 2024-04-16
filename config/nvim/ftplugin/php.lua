-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4

vim.wo.signcolumn  = 'yes'

vim.keymap.set('', '<Leader>r', '<Cmd>Update<CR><Cmd>TermExec cmd="php %"<CR>')

vim.cmd("Rooter")
