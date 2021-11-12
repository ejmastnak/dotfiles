lua require'lspconfig'.jedi_language_server.setup{}

" use <C-Space> for Jedi omnicompletion
inoremap <silent> <buffer> <C-Space> <C-x><C-o><Down>
" inoremap <silent> <buffer> . .<C-x><C-o><Down>

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

:set completeopt=longest,menuone
