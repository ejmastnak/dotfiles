" Settings for working with lytex files, which combine LilyPond and LaTeX

" " Only load remainder of plugin if a lytex plugin has not yet been loaded for this buffer
" if exists("b:did_lytex_plugin")
"   finish
" endif
" let b:did_lytex_plugin = 1

" load LaTeX syntax
if !exists("b:current_syntax")
  source $VIMRUNTIME/syntax/tex.vim
  let b:current_syntax = "lytex"
endif

" turn off automatic indenting in enumerated environments
let g:tex_indent_items=0

" load LaTeX indent
if !exists("b:did_indent")
  source $VIMRUNTIME/indent/tex.vim
  let b:did_indent = 1
endif

" indentation setting as for LaTeX
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4


" BEGIN COMPILATION COMMANDS
" --------------------------------------------- "
" write the line "LYTEX" to the file "/tmp/inverse-search-target.txt"
call system(printf("echo %s > %s", "LYTEX", "/tmp/inverse-search-target.txt"))

let s:lilybook_output_dir = "lilybook-out"
let s:forward_show_script = "$HOME/.config/nvim/personal/lilypond-scripts/lytex-forward-show.sh"

" compilation commands kept in variables for easier reuse across multiple functions

" TLDR: lilypond-book --pdf --output=lilybook-out --format=latex lytex_file
let s:compile_lily_command = "lilypond-book --pdf --output=" . 
        \ expand(s:lilybook_output_dir) . " --format=latex $(VIM_FILENAME)"

" TLDR: pdflatex {... options ...} tex_file
let s:compile_tex_command = "pdflatex -output-dir=" .
        \ expand(s:lilybook_output_dir) . " -file-line-error " .
        \ "-interaction=nonstopmode -halt-on-error -synctex=1 " .
        \ expand(s:lilybook_output_dir) . "/$(VIM_FILENOEXT).tex"
" --------------------------------------------- "
" END COMPILATION COMMANDS


" BEGIN COMPILATION FUNCTIONS
" ------------------------------------------- "
" compile .lytex file with lilypond-book
function! s:LytexCompileLytex() abort
  update
  execute "AsyncRun " . expand(s:compile_lily_command)
endfunction

" compile generated .tex file with pdflatex
function! s:LytexCompileTex() abort
  execute "AsyncRun " . expand(s:compile_tex_command)
endfunction

" compile .lytex file, then compile generated .tex file
function! s:LytexCompileAll() abort
  update
  execute "AsyncRun " . expand(s:compile_lily_command) .
        \ " && " . expand(s:compile_tex_command)
endfunction

" move pdf file to position corresponding to current line in .lytex file
function! s:LytexForwardShow() abort
  update
  " TLDR: AsyncRun sh forward_show_script lytex_line lytex_file tex_file pdf_file
  execute "AsyncRun sh " . expand(s:forward_show_script) . " " .
        \ line('.') .
        \ " $(VIM_RELNAME) " .
        \ "$(VIM_RELDIR)/" . expand(s:lilybook_output_dir) . "/$(VIM_FILENOEXT).tex " .
        \ "$(VIM_RELDIR)/" . expand(s:lilybook_output_dir) . "/$(VIM_FILENOEXT).pdf " .
        \ expand(g:os_current)
endfunction
" ------------------------------------------- "
" END COMPILATION FUNCTIONS


" BEGIN MAPPINGS
" ------------------------------------------- "
" LytexCompileLytex
nmap <leader>l <Plug>LytexCompileLytex
noremap <script> <Plug>LytexCompileLytex <SID>LytexCompileLytex
noremap <SID>LytexCompileLytex :call <SID>LytexCompileLytex()<CR>

" LytexCompileTex
nmap <leader>t <PlugLytexCompileTex>
noremap <script> <Plug>LytexCompileTex <SID>LytexCompileTex
noremap <SID>LytexCompileTex :call <SID>LytexCompileTex()<CR>

" LytexCompileAll
nmap <leader>r <Plug>LytexCompileAll
noremap <script> <Plug>LytexCompileAll <SID>LytexCompileAll
noremap <SID>LytexCompileAll :call <SID>LytexCompileAll()<CR>

" LytexForwardShow
nmap <leader>v <Plug>LytexForwardShow
noremap <script> <Plug>LytexForwardShow <SID>LytexForwardShow
noremap <SID>LytexForwardShow :call <SID>LytexForwardShow()<CR>
" ------------------------------------------- "
" END MAPPINGS
