" shell script settings

" Setting indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" nnoremap <leader>r <Cmd>execute 'AsyncRun sh ' . expand('%')<CR>

let g:sh_term_job_id = -1

function! ShellHandleTermExit(job_id, data, event) abort
  echom "Exiting"
  let g:sh_term_job_id = -1
endfunction

function! s:ShellRunProgram() abort
  update
  if g:sh_term_job_id < 0
    belowright 10new
    let g:sh_term_job_id = termopen("zsh", {'on_exit': 'ShellHandleTermExit'})

    if g:sh_term_job_id <= 0
      echom "Failed to open terminal."
      return
    endif

    " Always keep the terminal window at the same size
    set winfixheight

    " Return to original buffer
    wincmd k

    call jobsend(g:sh_term_job_id, "sh " . expand("%")."\n")
  else
    call jobsend(g:sh_term_job_id, "sh " . expand("%")."\n")
  endif
endfunction

nmap <leader>r <Plug>ShellRunProgram
nnoremap <script> <Plug>ShellRunProgram <SID>ShellRunProgram
nnoremap <SID>ShellRunProgram :call <SID>ShellRunProgram()<CR>
