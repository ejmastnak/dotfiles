vim.g.rooter_patterns = {'.git', 'Makefile', 'package.json', '.root', 'build/env.sh', 'init.lua'}

vim.g.rooter_manual_only = 1
vim.keymap.set('', '<Leader>tr', '<Cmd>Rooter<CR>')

-- Automatically source local init.lua file if present
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    local config_file = vim.fn.getcwd() .. '/init.lua'
    if vim.fn.filereadable(config_file) == 1 then
      vim.cmd('source ' .. config_file)
    end
  end,
})
