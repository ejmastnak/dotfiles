-- UltiSnips Snippet keys
vim.g.UltiSnipsExpandTrigger = '<Tab>'
vim.g.UltiSnipsJumpForwardTrigger = 'jk'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-j>'
vim.g.UltiSnipsSnippetDirectories = {os.getenv('HOME') .. '/.config/nvim/UltiSnips'}

vim.keymap.set('', '<Leader>U', '<Cmd>echo "Snippets refreshed!"<Cmd>call UltiSnips#RefreshSnippets()<CR>')
