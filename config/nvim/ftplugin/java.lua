-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4

vim.keymap.set('', '<Leader>c', '<Cmd>update<CR><Cmd>TermExec cmd="javac %"<CR>')
vim.keymap.set('', '<Leader>r', '<Cmd>update<CR><Cmd>TermExec cmd="java -cp %:h %:r"<CR>')
