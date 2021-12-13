" Python settings

" indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal foldmethod=indent
setlocal foldlevel=99

nnoremap <leader>r :execute "AsyncRun -save=2 " .
      \ "python3 %"<CR>
