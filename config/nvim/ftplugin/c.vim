" Setting indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

compiler mygcc

" Compile current C file
noremap <leader>c <Cmd>Make<CR>

" Execute C program generated from current C file
noremap <leader>r <Cmd>belowright 10split term://./%:r<CR>
