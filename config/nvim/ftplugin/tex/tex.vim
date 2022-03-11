" My LaTex settings

" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mytexplugin")
  finish
endif
let b:did_mytexplugin = 1

let g:tex_flavor = 'latex'  " recognize tex files as latex

" setting indentation
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Turn off automatic indenting in enumerated environments
let g:tex_indent_items=0

" Compilation
nnoremap <leader>r :update<CR>:VimtexCompileSS<CR>

" Write the line "TEX" to the file "/tmp/inverse-search-target.txt".
" I use the file  "/tmp/inverse-search-target.txt" as part of making inverse 
" search work for both LaTeX and Lilypond LyTeX files.
call system(printf("echo %s > %s", "TEX", "/tmp/inverse-search-target.txt"))

" For switching focus from Zathura to Vim using xdotool
let g:window_id = system("xdotool getactivewindow")

" BEGIN FORWARD SHOW
" ---------------------------------------------
" Linux forward search implementation
if g:os_current == "Linux"

  function! s:TexForwardShowZathura() abort
    VimtexView
    execute "!xdotool windowfocus " . expand(g:window_id)
    redraw!
  endfunction

  nmap <leader>v <Plug>TexForwardShow
  noremap <script> <Plug>TexForwardShow <SID>TexForwardShow
  noremap <SID>TexForwardShow :call <SID>TexForwardShowZathura()<CR>

" macOS forward search implementation
elseif g:os_current == "Darwin"
  nnoremap <leader>v :execute "Start! " .
        \ "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g " .
        \ line('.') . " " .
        \ expand('%:r') . ".pdf " .
        \ expand('%')<CR>
else
  echom "Error: forward show not supported on this OS"
endif
" ---------------------------------------------
" END COMPILATION AND PDF READER SUPPORT
