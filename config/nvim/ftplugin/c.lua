-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4
vim.wo.signcolumn  = 'yes'

vim.cmd("Rooter")
vim.keymap.set('', '<Leader>c', '<Cmd>update<CR><Cmd>TermExec cmd="make %:t:r"<CR>')
vim.keymap.set('', '<Leader>C', '<Cmd>update<CR><Cmd>TermExec cmd="gcc %:p -o %:p:r"<CR>')

vim.keymap.set('n', '<Leader>r', function()
  -- Turns e.g. ~/src/foo/bar/baz.c into ~/src/foo/bar/baz
  local filepath = vim.fn.expand('%:p:r')
  
  if vim.fn.filereadable(filepath) ~= 0 then
    -- If a sibling executable exists, execute it directly
    vim.cmd('TermExec cmd="' .. filepath .. '"')
  else
    -- Otherwise execute a corresponding file in bin directory of project root
    local filename = vim.fn.expand('%:t:r')
    vim.cmd('TermExec cmd="bin/' .. filename .. '"')
  end
end)
