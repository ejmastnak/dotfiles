-- Config for nvim-dap

-- Start a new debug session or resume an existing one
vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
-- Terminate the existing debug session
vim.keymap.set('n', '<Leader>dt', function() require('dap').terminate() end)

-- Toggle breakpoint at current line
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
-- List all break points
vim.keymap.set('n', '<Leader>dbl', function() require('dap').list_breakpoints(); vim.cmd('copen'); vim.cmd('wincmd p') end)
vim.keymap.set('n', '<Leader>dbc', function() require('dap').clear_breakpoints() end)

-- Step through execution stack
vim.keymap.set('n', '<Leader>dn', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>do', function() require('dap').step_out() end)

-- Toggle a REPL to evaluate expressions
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.toggle({}, 'belowright 10split +set\\ wfh new') end)

-- Configure size of terminal
local dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = 'belowright 6split +set\\ wfh new'
