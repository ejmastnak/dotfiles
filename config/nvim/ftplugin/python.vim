" Python settings

" indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal foldmethod=indent
setlocal foldlevel=99

" start language server
source ~/.config/nvim/personal/lsp/lsp-config.vim
source ~/.config/nvim/personal/lsp/jedi-server-config.vim
" LspStart jedi_language_server

nnoremap <leader>r :execute "AsyncRun -save=2 " .
      \ "python3 %"<CR>
