-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4
vim.wo.foldmethod  = 'indent'
vim.wo.foldlevel   = 99
vim.wo.signcolumn  = 'yes'

vim.keymap.set('', '<Leader>r', '<Cmd>update<CR><Cmd>TermExec cmd="python3 %"<CR>', {buffer = true})

-- Source Jedi language server config
require('lsp.jedi-server')

-- Source debug adapter protocol for Python
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
