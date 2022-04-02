" Delete character to the right of the cursor
inoremap <C-K> <Right><BS>
" <C-E> to delete word to the right of cursor (converse of <C-W>)
inoremap <C-E> <C-O>dw
" <C-D> (control+D) to delete line to the right of cursor (converse of <C-U>)
inoremap <C-D> <C-O>D

inoremap <expr> <BS> <SID>DeletePairedDelimeter()
function! s:DeletePairedDelimeter() abort
  " adapted from https://vi.stackexchange.com/a/24763

  " First checks if the cursor as at line start or line end
  " ...For reasons I haven't figured out, adding these separate cases
  " ...fixes a problem with the original solution, which would
  " ...delete the first character in a line when typing <BS> at line start
  " ...or move the line below up when when typing <BS> at line start
  if col(".") == col("^") + 1 || col(".") == col("$")
    return "\<BS>"
  else
    " get characters on either side of cursor
    let pair = getline('.')[col('.')-2 : col('.')-1]
    echom pair
    " check if cursor is placed inside a paired delimeter
    if stridx('""''''()[]<>{}``', pair) % 2 == 0
      " deletes paired delimiter
      return "\<Right>\<BS>\<BS>"
    else  " cursor was not between paired delimiters
      " normal functionality
      return "\<BS>"
    endif
  endif
endfunction
