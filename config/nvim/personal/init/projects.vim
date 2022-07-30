" About: settings for managing and building multi-file projects

" quit current project <leader>q
" run/build current project <leader>p

let g:project_command_file = '.vim-project-command'
let g:project_term_job_id = -1

function! s:ProjectRunJob() abort

  if g:project_term_job_id > 0
    echom "Project job is already running!"
    return
  endif

  " Change into project root dir
  Rooter

  " Ensure project job exists and is executable
  if !filereadable("./" . g:project_command_file) || !executable("./" . g:project_command_file)
    echom "Project job file does not exist, is not readable, or is not executable."
    return
  endif

  " Open a new terminal running ZSH
  belowright 8new
  let g:project_term_job_id = termopen("zsh", {'on_exit': 'ProjectHandleExit'})

  if g:project_term_job_id <= 0
    echom "Failed to open terminal."
    return
  endif

  " Execute project command
  call jobsend(g:project_term_job_id, "./" . g:project_command_file . "\n")

  " Return from terminal window to main window
  sleep 100m
  wincmd k

endfunction

function! ProjectHandleExit(job_id, data, event) abort
  echom "Exiting"
  let g:project_term_job_id = 0
endfunction

nmap <leader>p <Plug>ProjectRunJob
nnoremap <script> <Plug>ProjectRunJob <SID>ProjectRunJob
nnoremap <SID>ProjectRunJob :call <SID>ProjectRunJob()<CR>
