" This file configures Vim's errorformat variable to detect common LaTeX compilation error messages compiling LaTeX documents
" Source: this errorformat is taken from lervag's vimtex plugin.
" The original values are found in the qf.set_errorformat function in vimtex/autoload/vimtex/qf/latexlog.vim file


" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mytexplugin_errorformat")
  finish
endif
let b:did_mytexplugin_errorformat = 1


" IMPORTANT: the errorformat specified in this file 
" ... assumes the tex source file is compiled with 
" ... pdflatex's -file-line-error option enabled

setlocal errorformat=%-P**%f
setlocal errorformat+=%-P**\"%f\"

" Match errors
setlocal errorformat+=%E!\ LaTeX\ %trror:\ %m
setlocal errorformat+=%E%f:%l:\ %m
setlocal errorformat+=%E!\ %m

" More info for undefined control sequences
setlocal errorformat+=%Z<argument>\ %m

" More info for some errors
setlocal errorformat+=%Cl.%l\ %m

" Ignore unmatched lines
setlocal errorformat+=%-G%.%#

" I find the remaining vimtex additions to errorformat unnecessary,
" but have included them below, commented out, as a reference

""
"" Define general warnings
""
"setlocal errorformat+=%+WLaTeX\ Font\ Warning:\ %.%#line\ %l%.%#
"setlocal errorformat+=%-CLaTeX\ Font\ Warning:\ %m
"setlocal errorformat+=%-C(Font)%m

"setlocal errorformat+=%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#
"setlocal errorformat+=%+WLaTeX\ %.%#Warning:\ %m

"setlocal errorformat+=%+WOverfull\ %\\%\\hbox%.%#\ at\ lines\ %l--%*\\d
"setlocal errorformat+=%+WOverfull\ %\\%\\hbox%.%#\ at\ line\ %l
"setlocal errorformat+=%+WOverfull\ %\\%\\vbox%.%#\ at\ line\ %l

"setlocal errorformat+=%+WUnderfull\ %\\%\\hbox%.%#\ at\ lines\ %l--%*\\d
"setlocal errorformat+=%+WUnderfull\ %\\%\\vbox%.%#\ at\ line\ %l

""
"" Define package related warnings
""
"setlocal errorformat+=%+WPackage\ natbib\ Warning:\ %m\ on\ input\ line\ %l.

"setlocal errorformat+=%+WPackage\ biblatex\ Warning:\ %m
"setlocal errorformat+=%-C(biblatex)%.%#in\ t%.%#
"setlocal errorformat+=%-C(biblatex)%.%#Please\ v%.%#
"setlocal errorformat+=%-C(biblatex)%.%#LaTeX\ a%.%#
"setlocal errorformat+=%-C(biblatex)%m

"setlocal errorformat+=%+WPackage\ babel\ Warning:\ %m
"setlocal errorformat+=%-Z(babel)%.%#input\ line\ %l.
"setlocal errorformat+=%-C(babel)%m

"setlocal errorformat+=%+WPackage\ hyperref\ Warning:\ %m
"setlocal errorformat+=%-C(hyperref)%m\ on\ input\ line\ %l.
"setlocal errorformat+=%-C(hyperref)%m

"setlocal errorformat+=%+WPackage\ scrreprt\ Warning:\ %m
"setlocal errorformat+=%-C(scrreprt)%m

"setlocal errorformat+=%+WPackage\ fixltx2e\ Warning:\ %m
"setlocal errorformat+=%-C(fixltx2e)%m

"setlocal errorformat+=%+WPackage\ titlesec\ Warning:\ %m
"setlocal errorformat+=%-C(titlesec)%m

"setlocal errorformat+=%+WPackage\ %.%#\ Warning:\ %m\ on\ input\ line\ %l.
"setlocal errorformat+=%+WPackage\ %.%#\ Warning:\ %m
"setlocal errorformat+=%-Z(%.%#)\ %m\ on\ input\ line\ %l.
"setlocal errorformat+=%-C(%.%#)\ %m
