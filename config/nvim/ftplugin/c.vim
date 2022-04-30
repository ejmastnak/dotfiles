" Setting indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

compiler mygcc

noremap <leader>c <Cmd>Make<CR>

noremap <leader>r :execute "AsyncRun -save=2 ./%:r"<CR>

