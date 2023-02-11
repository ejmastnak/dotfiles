vim.g.rooter_patterns = {'.git', 'Makefile', 'package.json', '.root', 'build/env.sh'}

vim.g.rooter_manual_only = 1
vim.keymap.set('', '<Leader>tr', '<Cmd>Rooter<CR>')
