" My LaTex settings

" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mycsvplugin")
  finish
endif
let b:did_mycsvplugin = 1

" Move one cell forward
noremap W f,l

" Move to end of current cell or one cell forward
" if at the end of the current cell.
noremap E lf,h

" Move to beginning of current cell or one cell backward
" if at the beginning of the current cell.
noremap B hF,l

" Move to end of line
noremap L $

" Move to start of line
noremap H ^

" "Field" text object
xnoremap if :<C-u>normal! T,vt,<CR>
onoremap if :normal vi,<CR>
xnoremap af :<C-u>normal! F,vf,<CR>
onoremap af :normal va,<CR>
