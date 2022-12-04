" A config file for using Vim to edit LaTeX for later inclusion in Anki notes

" setting indentation
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Used to delete scratchpad file when exiting Vim
function! DeleteScratchpad()
  " Copy contents of buffer to system clipboard
  %y+

  if exists('g:anki_scratchpad_file')
    call system('rm '. g:anki_scratchpad_file)
  endif
endfunction

augroup ankitex_close_editor
  au!
  au VimLeave * call DeleteScratchpad()
augroup END

normal j
startinsert
