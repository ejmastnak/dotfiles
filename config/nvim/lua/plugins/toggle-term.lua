require("toggleterm").setup{
  shade_terminals = false
}

vim.keymap.set('n', '<Leader>tt', '<Cmd>ToggleTerm<CR>')
vim.keymap.set('n', '<Leader>t1', '<Cmd>1ToggleTerm<CR>')
vim.keymap.set('n', '<Leader>t2', '<Cmd>2ToggleTerm<CR>')
