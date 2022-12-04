-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4

vim.cmd('compiler mygcc')

vim.keymap.set('', '<Leader>r', '<Cmd>TermExec cmd="%:p:r"<CR>')
vim.keymap.set('', '<Leader>c', '<Cmd>Make<CR>')
