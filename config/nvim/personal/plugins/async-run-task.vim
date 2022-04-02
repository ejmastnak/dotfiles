" AsyncRun and AsyncTaks

" Automatically open QuickFix menu with the given number of rows 
let g:asyncrun_open = 8      

" Remove empty lines from QuickFix list
let g:asyncrun_trim = 1      

noremap <silent><leader>q :call asyncrun#stop('')<cr>
noremap <silent><leader>p :AsyncTask project-build-serve<cr>

