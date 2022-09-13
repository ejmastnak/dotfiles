-- Use <C-Space> for Jedi omnicompletion
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', {silent = true, buffer = true})
vim.keymap.set('i', '<CR>', function()
    return vim.fn.pumvisible() == 1 and '<C-y>' or '<C-g>u<CR>'
end, {expr = true})

vim.opt.completeopt = {"longest", "menuone"}
