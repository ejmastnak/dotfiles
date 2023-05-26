-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth  = 2

-- For adding track number to YAML media tag files
-- Made repeatable thanks to tpope's vim-repeat with help from
-- http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
vim.keymap.set('n', '<Plug>AddTrackNumber', 'yy6jp$<C-a>:call repeat#set("\\<Plug>AddTrackNumber")<CR>', {remap=true, silent=true})
vim.keymap.set('n', 'TT', '<Plug>AddTrackNumber', {remap = true})
