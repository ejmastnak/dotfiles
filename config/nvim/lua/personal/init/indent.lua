vim.o.expandtab   = true
vim.o.autoindent  = true
vim.o.tabstop     = 2
vim.o.softtabstop = 2
vim.o.shiftwidth  = 2

-- For when Treesitter(?) overrides indentation
vim.keymap.set('n', '<Leader>i', function()
  vim.bo.expandtab   = true
  vim.bo.autoindent  = true
  vim.bo.tabstop     = 2
  vim.bo.softtabstop = 2
  vim.bo.shiftwidth  = 2
end)
