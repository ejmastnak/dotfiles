-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth  = 2

vim.keymap.set('', '<Leader>r', '<Cmd>Update<CR><Cmd>TermExec cmd="sh %"<CR>')
