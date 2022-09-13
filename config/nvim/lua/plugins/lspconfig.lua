vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', {silent = true})
vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.rename()<CR>', {silent = true})
vim.keymap.set('n', 'gR', '<Cmd>lua vim.lsp.buf.references()<CR>', {silent = true})

-- nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
-- nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

-- nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

-- to easily restart LSP
-- nnoremap <leader>l <Cmd>LspRestart<CR>
