" My LaTex settings

" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mytexplugin")
  finish
endif
let b:did_mytexplugin = 1

let g:tex_flavor = 'latex'  " recognize tex files as latex
compiler mytex              " load my user-defined tex compiler

" Write the line "TEX" to the file "/tmp/inverse-search-target.txt".
" I use  "/tmp/inverse-search-target.txt" to make inverse search 
" work for both LaTeX and Lilypond LyTeX files.
call system(printf("echo %s > %s", "TEX", "/tmp/inverse-search-target.txt"))

" setting indentation
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Turn off automatic indenting in enumerated environments
let g:tex_indent_items=0

" Compilation
nnoremap <leader>r :Make<CR>
" let g:dispatch_no_tmux_make = 1

" Forward show
nnoremap <leader>v :execute "Start! " .
      \ "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g " .
      \ line('.') . " " .
      \ expand('%:r') . ".pdf " .
      \ expand('%')<CR>
" Goal: suppress all output for forward show command.
" (Hacked) solution: Disable vim-dispatch's terminal mode for Start commands,
"  which makes vim-dispatch fall back to headless mode which has no output.
let g:dispatch_no_terminal_start = 1


" Configuration options for the vimtex plugin
" ---------------------------------------------
let g:vimtex_compiler_enabled = 0   " turn off compilation interface
let g:vimtex_view_enabled = 0       " turn off pdf viewer interface
let g:vimtex_indent_enabled = 0     " turn off vimtex indentation
let g:vimtex_imaps_enabled = 0      " turn off insert mode mappings (I use UltiSnips)
let g:vimtex_complete_enabled = 0   " turn off completion (not currently used so more efficient to turn off)

" vimtex toggle delimeter configuration
" ------------------------------- "
let g:vimtex_delim_list = {'mods' : {}}
let g:vimtex_delim_list.mods.name = [
      \ ['\left', '\right'],
      \ ['\mleft', '\mright'],
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \ ['\big', '\big'],
      \ ['\Big', '\Big'],
      \ ['\bigg', '\bigg'],
      \ ['\Bigg', '\Bigg'],
      \]
let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\big', '\big'],
  \]

" default is 500 and often give lags on missed key presses
let g:vimtex_delim_stopline = 5
