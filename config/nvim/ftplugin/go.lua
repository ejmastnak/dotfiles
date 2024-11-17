-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4
vim.wo.signcolumn  = 'yes'

vim.keymap.set('', '==', function()
  vim.cmd("!gofmt -w %")
  vim.cmd("edit")
end)

vim.keymap.set('', '<Leader>r', '<Cmd>update<CR><Cmd>TermExec cmd="go run %"<CR>', {buffer = true})
