" Settings for compiling LaTeX documents
if exists("current_compiler")
	finish
endif
let current_compiler = "mytex"

" Begin project root detection
" ---------------------------------------------
" Search for the string "TEXROOT" in the first few lines of the document
" Set the variable `b:tex_root` if "TEXROOT" is detected.
" --------------------------------------------- "
let b:tex_root_file = system("head -5 " . expand('%') . 
      \ '| grep "^%TEXROOT" ' . 
      \ '| awk -F "=" ''{print $2}'' ' .
      \ '| sed ''s/ *$//''')

if len(b:tex_root_file) == 0
  let b:tex_root_file = expand('%:p')  " use current file as project root
  let b:tex_root_dir = expand('%:p:h')
else  " 'TEXROOT' found in preamble; current file is NOT project root
  let b:tex_root_file = fnamemodify(b:tex_root_file, ':p')
  let b:tex_root_dir = fnamemodify(b:tex_root_file, ':p:h')
endif

" make programs using pdflatex or latexmk
let s:pdflatex = 'pdflatex -file-line-error -interaction=nonstopmode ' .
      \ '-halt-on-error -synctex=1 -output-directory=' . expand(b:tex_root_dir)
let s:latexmk = 'latexmk -pdf -output-directory=' . expand(b:tex_root_dir)
" ---------------------------------------------
" End project root detection


" Variables used to toggle latexmk and shell-escape compilation on and off.
" Values are initialized to zero, then potentially turned on below.
let b:tex_compile_use_latexmk = 0
let b:tex_compile_use_shell_escape = 0


" Search for the minted package in the document preamble.
" Enable b:tex_compile_use_shell_escape if the minted package
" is detected in the tex file's preamble.
" --------------------------------------------- "
silent execute '!sed "/\\begin{document}/q" ' . expand('%') . ' | grep "minted" > /dev/null'
if v:shell_error  " 'minted' not found in preamble
  let b:tex_compile_use_shell_escape = 0  " disable shell escape
else  " 'minted' found in preamble
  let b:tex_compile_use_shell_escape = 1  " enable shell escape
endif


" Begin user-defined functions
" ------------------------------------------- "
" Toggles between latexmk and pdflatex
function! s:TexToggleLatexmk() abort
  if b:tex_compile_use_latexmk  " turn off latexmk
    let b:tex_compile_use_latexmk = 0
  else  " turn on latexmk
    let b:tex_compile_use_latexmk = 1
  endif
  call s:TexSetMakePrg()  " update makeprg
endfunction

" Toggles shell escape compilation on and off
function! s:TexToggleShellEscape() abort
  if b:tex_compile_use_shell_escape  " turn off shell escape
    let b:tex_compile_use_shell_escape = 0
  else  " turn on shell escape
    let b:tex_compile_use_shell_escape = 1
  endif
  call s:TexSetMakePrg()  " update makeprg
endfunction

" Sets correct value of makeprg based on current values of 
" b:tex_compile_use_latexmk and b:tex_compile_use_shell_escape
function! s:TexSetMakePrg() abort
  if b:tex_compile_use_latexmk
    let &l:makeprg = expand(s:latexmk)
  else
    let &l:makeprg = expand(s:pdflatex)
  endif
  if b:tex_compile_use_shell_escape
    let &l:makeprg = &makeprg . ' -shell-escape'
  endif
  " let &l:makeprg = &makeprg . ' %'
  let &l:makeprg = &makeprg . ' ' . b:tex_root_file
endfunction
" ---------------------------------------------
" End user-defined functions


" Key mappings for functions
" ---------------------------------------------
" TexToggleShellEscape
nmap <leader>te <Plug>TexToggleShellEscape
nnoremap <script> <Plug>TexToggleShellEscape <SID>TexToggleShellEscape
nnoremap <SID>TexToggleShellEscape :call <SID>TexToggleShellEscape()<CR>

" TexToggleLatexmk
nmap <leader>tl <Plug>TexToggleLatexmk
nnoremap <script> <Plug>TexToggleLatexmk <SID>TexToggleLatexmk
nnoremap <SID>TexToggleLatexmk :call <SID>TexToggleLatexmk()<CR>


" Set makeprg and errorformat
" ---------------------------------------------
call s:TexSetMakePrg()

" Note: The errorformat used below assumes the tex source file is 
" compiled with pdflatex's -file-line-error option enabled.
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
