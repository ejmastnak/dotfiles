" My LaTex settings

" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mytexplugin")
  finish
endif
let b:did_mytexplugin = 1

let g:tex_flavor = 'latex'  " recognize tex files as latex
compiler mytex              " load my user-defined tex compiler

" setting indentation
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Turn off automatic indenting in enumerated environments
let g:tex_indent_items=0


" BEGIN COMPILATION AND PDF READER SUPPORT
" ---------------------------------------------
" Write the line "TEX" to the file "/tmp/inverse-search-target.txt".
" I use  "/tmp/inverse-search-target.txt" to make inverse search 
" work for both LaTeX and Lilypond LyTeX files.
call system(printf("echo %s > %s", "TEX", "/tmp/inverse-search-target.txt"))

" Compilation
nnoremap <leader>r :Make<CR>
" let g:dispatch_no_tmux_make = 1

" Forward show
" ---------------------------------------------
" Goal: suppress all output for forward show command.
" (Hacked) solution: Disable vim-dispatch's terminal mode for Start commands,
"  which makes vim-dispatch fall back to headless mode which has no output.
let g:dispatch_no_terminal_start = 1


if g:os_current == "Linux"
  echom "TODO: implement forward show on Linux"
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
