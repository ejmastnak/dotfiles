" Setting indentation settings
setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

let g:php_term_job_id = -1
let g:php_index_file = expand("%")

function! PHPHandleTermExit(job_id, data, event) abort
  echom "Exiting"
  let g:php_term_job_id = -1
endfunction

function! s:PHPRunServer() abort
  update
  if g:php_term_job_id < 0
    belowright 10new
    let g:php_term_job_id = termopen("zsh", {'on_exit': 'PHPHandleTermExit'})

    if g:php_term_job_id <= 0
      echom "Failed to open terminal."
      return
    endif

    " Always keep the terminal window at the same size
    set winfixheight

    call jobsend(g:php_term_job_id, "php -S localhost:8888 " . g:php_index_file . "\n")
  else
    echom "Server is already running!"
  endif
endfunction

nmap <leader>r <Plug>PHPRunServer
nnoremap <script> <Plug>PHPRunServer <SID>PHPRunServer
nnoremap <SID>PHPRunServer :call <SID>PHPRunServer()<CR>
