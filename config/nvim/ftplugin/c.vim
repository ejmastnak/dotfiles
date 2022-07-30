" Setting indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

compiler mygcc

" Compile current C file
noremap <leader>c <Cmd>Make<CR>

" " Execute C program generated from current C file
" noremap <leader>r <Cmd>belowright 10split term://./%:r<CR>

let g:c_term_job_id = -1

function! CHandleTermExit(job_id, data, event) abort
  echom "Exiting"
  let g:c_term_job_id = -1
endfunction

function! s:CRunProgram() abort
  update
  if g:c_term_job_id < 0
    belowright 10new
    let g:c_term_job_id = termopen("zsh", {'on_exit': 'CHandleTermExit'})

    if g:c_term_job_id <= 0
      echom "Failed to open terminal."
      return
    endif

    " Always keep the terminal window at the same size
    set winfixheight

    " TODO: at this point record the buffer name and window ID
    " Then use `WinClosed` Event, matching agains window ID, to `bdelete b:name`
    " Like autocmd WinClosed g:windowID bdelete b:name
    " Or cleaner would be to programatically exit the process with e.g. `jobstop`

    call jobsend(g:c_term_job_id, expand("%:p:r")."\n")
  else

    " TODO: move terminal text to top of screen. Hacky way would be to focus
    " to terminal window and call e.g. `normal zt` to move terminal to top of
    " screen. Better is e.g. Neovim window API if you can use it to send
    " commands to a window without switching to the window.

    call jobsend(g:c_term_job_id, expand("%:p:r")."\n")
  endif
endfunction

nmap <leader>r <Plug>CRunProgram
nnoremap <script> <Plug>CRunProgram <SID>CRunProgram
nnoremap <SID>CRunProgram :call <SID>CRunProgram()<CR>
