-- Configuration related to copying and pasting

if vim.g.os_current == 'Linux' then
  vim.opt.clipboard = 'unnamedplus'
elseif vim.g.os_current == 'Darwin' then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus'
end

-- Make Y work like D or C
vim.keymap.set('n', 'Y', 'y$')

-- Stop cc, x, and X from overwriting default register
vim.keymap.set('n', 'cc', '"_cc')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')

-- Paste in visual mode without overwriting default register
vim.keymap.set('v', 'p', 'P')
