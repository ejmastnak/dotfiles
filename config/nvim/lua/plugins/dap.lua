-- Config for nvim-dap

vim.keymap.set('n', '<Leader>dp', function() require('dap').continue() end)

vim.keymap.set('n', '<Leader>dn', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>do', function() require('dap').step_out() end)

vim.keymap.set('n', '<Leader>dd', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dD', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)

vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.toggle() end)

vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
    end)

vim.keymap.set({'n', 'v'}, '<Leader>dv', function()
    require('dap.ui.widgets').preview()
    end)

vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
    end)

vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
    end)
