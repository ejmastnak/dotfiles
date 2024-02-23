-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth  = 2

vim.keymap.set('', '<Leader>r', '<Cmd>write<CR><Cmd>TermExec cmd="dot -Tpng % -o %:r.png"<CR>')
