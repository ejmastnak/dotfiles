" My LaTex settings

" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mytexplugin")
  finish                      " exit if did_mytexplugin is true
endif
let b:did_mytexplugin = 1       " plugin is loaded 

let g:tex_flavor = 'latex'		" recognize tex files as latex

" setting indentation
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

" turn off automatic indenting in enumerated environments
let g:tex_indent_items=0

" write the line "TEX" to the file "/tmp/inverse-search-target.txt"
call system(printf("echo %s > %s", "TEX", "/tmp/inverse-search-target.txt"))
