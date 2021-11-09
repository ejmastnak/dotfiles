" Settings for compiling LaTeX documents

" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mytexplugin_compile")
  finish
endif
let b:did_mytexplugin_compile = 1

" paths to shell scripts used for compilation
let s:tex_scripts_dir = "$HOME/.config/nvim/personal/tex-scripts/"
let s:compile_script_path = s:tex_scripts_dir . "compile.sh"
let s:compile_show_script_path = s:tex_scripts_dir . "compile-show.sh"
let s:forward_show_script = "$HOME/.config/nvim/personal/forward-show.sh"

" used to toggle latexmk and shell-escape compilation on and off
let b:tex_compile_use_latexmk = 0
let b:tex_compile_use_shell_escape = 0


" Enable b:tex_compile_use_shell_escape if the minted package is detected in the tex file's preamble
" --------------------------------------------- "
silent execute '!sed "/\\begin{document}/q" ' . expand('%') . ' | grep "minted" > /dev/null'
if v:shell_error  " 'minted' not found in preamble
  let b:tex_compile_use_shell_escape = 0  " disable shell escape
else  " 'minted' found in preamble
  let b:tex_compile_use_shell_escape = 1  " enable shell escape
endif
" --------------------------------------------- "


" BEGIN FUNCTIONS
" ------------------------------------------- "
" function for toggling latexmk
function! tex_compile#toggle_latexmk() abort
  if b:tex_compile_use_latexmk  " turn off latexmk
    let b:tex_compile_use_latexmk = 0
  else  " turn on latexmk
    let b:tex_compile_use_latexmk = 1
  endif
endfunction

" function for toggling shell escape
function! tex_compile#toggle_shell_escape() abort
  if b:tex_compile_use_shell_escape  " turn off shell escape
    let b:tex_compile_use_shell_escape = 0
  else  " turn on shell escape
    let b:tex_compile_use_shell_escape = 1
  endif
endfunction

function! tex_compile#compile() abort
  update
  execute "AsyncRun sh " . expand(s:compile_script_path) . 
        \ " $(VIM_RELDIR)" . " $(VIM_FILENOEXT) " . 
        \ expand(b:tex_compile_use_latexmk) . " " . 
        \ expand(b:tex_compile_use_shell_escape)
endfunction

function! tex_compile#compile_show() abort
  update  " save buffer if necessary
  execute "AsyncRun sh " . expand(s:compile_show_script_path) .
        \ " $(VIM_RELDIR)" . " $(VIM_FILENOEXT) " .
        \ expand(b:tex_compile_use_latexmk) . " " .
        \ expand(b:tex_compile_use_shell_escape) . " " . line('.')
endfunction

function! tex_compile#forward_show() abort
  " TLDR: AsyncRun sh forward_show_script line pdf_file tex_file OS_name
  execute "AsyncRun sh " . expand(s:forward_show_script) . " " .
        \ line('.') .
        \ " $(VIM_RELDIR)/$(VIM_FILENOEXT).pdf " .
        \ " $(VIM_RELDIR)/$(VIM_FILENOEXT).tex " .
        \ expand(g:os_current)
endfunction
" ------------------------------------------- "
" END FUNCTIONS


" BEGIN MAPPINGS
" ------------------------------------------- "
" generic <Plug> mappings
noremap <Plug>TexToggleLatexmk :call tex_compile#toggle_latexmk()<CR>
noremap <Plug>TexToggleShellEscape :call tex_compile#toggle_shell_escape()<CR>
noremap <Plug>TexCompile :call tex_compile#compile()<CR>
noremap <Plug>TexCompileShow :call tex_compile#compile_show()<CR>
noremap <Plug>TexForwardShow :call tex_compile#forward_show()<CR>

" explicit mappings
nmap <leader>tl <Plug>TexToggleLatexmk
nmap <leader>te <Plug>TexToggleShellEscape
nmap <leader>r <Plug>TexCompile
nmap <leader>c <Plug>TexCompileShow
nmap <leader>v <Plug>TexForwardShow
" ------------------------------------------- "
" END MAPPINGS
