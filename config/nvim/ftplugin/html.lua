-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth  = 2

-- function OpenInBrowser()
--   vim.fn.jobstart("firefox " .. vim.fn.expand("%"))
-- end
--
-- vim.keymap.set('', '<Leader>v', OpenInBrowser)

-- Start npx serve
vim.keymap.set('n', '<Leader>r', function()
  vim.cmd('1TermExec cmd="npx serve"')
  vim.cmd("wincmd k")    -- Return cursor to original window
  vim.cmd("stopinsert")  -- Return to normal mode
end)

-- Open browser at localhost port 3000
vim.keymap.set('n', '<Leader>v', function()
  vim.cmd('2TermExec cmd="xdg-open http://localhost:3000/%"')
  vim.cmd("wincmd k")    -- Return cursor to original window
  vim.cmd("stopinsert")  -- Return to normal mode
end)
