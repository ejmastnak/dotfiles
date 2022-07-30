" Python settings

" indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal foldmethod=indent
setlocal foldlevel=99

noremap <leader>r <Cmd>update<CR><Cmd>belowright 10split term://python3 %<CR>

" Source LSP configuration
source ~/.config/nvim/personal/lsp/jedi-server-config.vim
