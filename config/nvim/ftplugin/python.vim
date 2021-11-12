" Python settings

" indentation settings
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set foldmethod=indent
set foldlevel=99

" start language server
source ~/.config/nvim/personal/lsp/lsp-config.vim
source ~/.config/nvim/personal/lsp/jedi-server-config.vim
LspStart jedi_language_server

" " start autocompletion plugin
" source ~/.config/nvim/personal/plugin/config/coq-config.vim
" COQnow
