-- require('telescope').setup{
--   defaults = {
--     file_ignore_patterns = {"^vendor/"}
--   } 
-- }

vim.keymap.set('n', '<Leader>ff', '<Cmd>lua require("telescope.builtin").find_files()<CR>')
vim.keymap.set('n', '<Leader>fr', '<Cmd>Rooter<CR><Cmd>lua require("telescope.builtin").find_files()<CR>')
vim.keymap.set('n', '<Leader>fj', '<Cmd>lua require("telescope.builtin").buffers()<CR>')
vim.keymap.set('n', '<Leader>fg', '<Cmd>lua require("telescope.builtin").live_grep()<CR>')
vim.keymap.set('n', '<Leader>f/', '<Cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>')
