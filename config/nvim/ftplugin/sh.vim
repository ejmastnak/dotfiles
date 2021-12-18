" shell script settings

" Setting indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

nnoremap <leader>r <Cmd>execute 'AsyncRun sh ' . expand('%')<CR>
