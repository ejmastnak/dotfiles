" Overwriting various coq_nvim key mappings

" Delete character to the right of the cursor
inoremap <C-K> <Right><BS>
" <C-E> to delete word to the right of the cursor (converse of <C-W>)
inoremap <C-E> <C-O>dw
" <C-BS> (control+backspace) to delete line to the right of the cursor (converse of <C-U>)
inoremap <C-Q> <C-O>D

" mappings for faster split window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

