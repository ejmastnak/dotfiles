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

" Compilation
nnoremap <leader>r :Make<CR>

" Write the line "TEX" to the file "/tmp/inverse-search-target.txt".
" I use the file  "/tmp/inverse-search-target.txt" as part of making inverse 
" search work for both LaTeX and Lilypond LyTeX files.
call system(printf("echo %s > %s", "TEX", "/tmp/inverse-search-target.txt"))

" Variables to track if a Zathura instance is currently open and displaying the
" PDF file associated with the current LaTeX buffer. 
" 1 means Zathura is open
" 0 means Zathura is closed
let b:zathura_open = 0   " initialize to closed
let b:zathura_job_id = 0

" For switching focus from Zathura to Vim using xdotool
let g:window_id = system("xdotool getactivewindow")

" BEGIN FORWARD SHOW
" ---------------------------------------------
" Linux forward search implementation
if g:os_current == "Linux"

  " Note that the entire command is intentionally enclosed in double quotes
  let s:inverse_command = 
        \'"${HOME}/.config/nvim/personal/inverse-search/latex-linux.sh ' .
        \ ' %{input} %{line} ' .
        \ expand(g:window_id) . '"'

  function! s:TexForwardShowZathura() abort
      " Human-readable version of forward_command:
      " --synctex-forward line:col:myfile.tex myfile.pdf
      let forward_command = " --synctex-forward " .
        \ line('.') . ":" .
        \ col('.') . ":" .
        \ expand('%:p') . " " .
        \ expand('%:p:r') . ".pdf"

      " If Zathura is already open.
      " Note that setting `b:zathura_open = 0` is taken care of
      " in the below jobstart call's `on_exit` handler.
      if b:zathura_open
        call jobstart("zathura " . forward_command)
        sleep 100m  " give Zathura time steal focus before calling xdotool

      " If Zathura is not yet open, set the -x (inverse search) option.
      else
        let b:zathura_job_id = jobstart("zathura -x " . 
              \ s:inverse_command . " " .
              \ forward_command,
              \ {'on_exit': 'ZathuraExit'})

        let b:zathura_open = 1
        sleep 250m  " give Zathura time to open and steal focus before calling xdotool
      endif

      " The xdotool call finishes quickly enough to run synchronously, i.e. with `execute !`
      execute "!xdotool windowfocus " . expand(g:window_id)
      redraw!
  endfunction

  " Callback function for use with job_start after Zathura closes.
  " Simply "turns off" the b:zathura_open variable.
  function! ZathuraExit(job_id, data, event)
    let b:zathura_open = 0
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


        " " Use Neovim's async jobstart function
        " call jobstart('sh $HOME/.config/nvim/personal/vimura.sh "' .
        "       \ forward_command . '" ' .
        "       \ g:window_id)

