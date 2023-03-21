vim.keymap.set('', 'gmo', "<Cmd>lua require('vim-mpv').open()<CR>")

vim.keymap.set('', 'gmq', "<Cmd>lua require('vim-mpv').close()<CR>")

vim.keymap.set('', 'gmp', "<Cmd>lua require('vim-mpv').toggle_play_pause()<CR>")

vim.keymap.set('', 'gmt', "<Cmd>lua require('vim-mpv').insert_timestamp(true)<CR>")

vim.keymap.set('', 'gmg', "<Cmd>lua require('vim-mpv').goto_timestamp(true)<CR>")

vim.keymap.set('', 'gmw', "<Cmd>lua require('vim-mpv').play_word_under_cursor()<CR>")

vim.keymap.set('', 'gmP', "<Cmd>lua require('vim-mpv').playlist_parallel()<CR>")

-- Grab X Window ID of window holding current Vim instance
if vim.fn.exists("g:vim_window_id") == 0 and vim.fn.executable("xdotool") ~= 0 then
  vim.g.vim_window_id = vim.fn.system("xdotool getactivewindow")
end

