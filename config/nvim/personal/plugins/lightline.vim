" Lightline status bar
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'component_function': {
      \   'fileformat': 'LightlineFileFormat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileEncoding',
      \ },
      \ }

" Hide file format for window widths below 70 cols
function! LightlineFileFormat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

" Hide file encoding for window widths below 70 cols
function! LightlineFileEncoding()
  return winwidth(0) > 70 ? &fileencoding : ''
endfunction

" Hide file type for window widths below 60 cols
function! LightlineFiletype()
  return winwidth(0) > 60 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
