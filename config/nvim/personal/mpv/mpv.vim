let g:mpv_last_seek_time = 0    " used to repeat the last seek duration
let s:mpv_socket = "/tmp/mpvsocket"
let s:mpv_scripts = "$HOME/.config/nvim/personal/mpv/"
let s:get_property_script = s:mpv_scripts . "get-property.sh"
let s:get_time_script = s:mpv_scripts . "get-time.sh"
let s:toggle_pause_script = s:mpv_scripts . "toggle-pause.sh"
let s:seek_script = s:mpv_scripts . "seek.sh"
let s:change_speed_script = s:mpv_scripts . "change-speed.sh"

" Checks if video is running by checking AsyncRun's job status.
function! s:MPVIsVideoRunning() abort
if g:asyncrun_status == "running"
  return 1
else
  return 0
endif
endfunction

function! s:MPVOpen(path_to_video) abort
  " Argument: path_to_video: string holding full path to video to be opened
  "           e.g. "~/Videos/test.mp4"

  execute 'AsyncRun mpv ' .
        \ '--pause ' .
        \ '--keep-open=yes ' .
        \ '--no-focus-on-open ' .
        \ '--geometry=0:0 ' .
        \ expand(a:path_to_video) . 
        \ " --input-ipc-server=" . expand(s:mpv_socket)
endfunction

function! s:MPVGetProperty(property) abort
  if s:MPVIsVideoRunning()
    execute "!sh " . expand(s:get_property_script) . " "
          \ . expand(s:mpv_socket) . " "
          \ . expand(a:property)
  endif
endfunction

function! s:MPVGetTime() abort
  if s:MPVIsVideoRunning()
    let l:time = system("sh " . expand(s:get_time_script) . " " . expand(s:mpv_socket))
    if v:shell_error == 0  " if command executed successfully
      return l:time
    else
      return ""
    endif
  else
    return ""
  endif
endfunction

function! s:MPVTogglePause() abort
  if s:MPVIsVideoRunning()
    execute "!sh " . expand(s:toggle_pause_script) . " "
          \ . expand(s:mpv_socket)
  endif
endfunction

function! s:MPVSeek(seconds_to_seek) abort
  if s:MPVIsVideoRunning()
    let g:mpv_last_seek_time = a:seconds_to_seek
    execute "!sh " . expand(s:seek_script) . " "
          \ . expand(s:mpv_socket) . " "
          \ . expand(a:seconds_to_seek)
  endif
endfunction

function! s:MPVChangeSpeed(faster_or_slower) abort
  if s:MPVIsVideoRunning()
    execute "!sh " . expand(s:change_speed_script) . " "
          \ . expand(s:mpv_socket) . " "
          \ . expand(a:faster_or_slower)
  endif
endfunction

" Commands
" ---------------------------------------------
command! -nargs=1 -complete=file MPVOpen call s:MPVOpen("<args>")
command! -nargs=1 MPVProperty call s:MPVGetProperty("<args>")
"-----------------------------------------

" Mappings
" ---------------------------------------------
" MPVOpen command
nnoremap <leader>o :MPVOpen ~/Media/academics/klf/

" MPVProperty command
nnoremap <leader>p :MPVProperty<Space>

" MPVTogglePause function
nmap `<Space> <Plug>MPVTogglePause
nnoremap <script> <Plug>MPVTogglePause <SID>MPVTogglePause
nnoremap <silent> <SID>MPVTogglePause <Cmd>silent call <SID>MPVTogglePause()<CR>

imap `<Space> <Plug>MPVTogglePause
inoremap <script> <Plug>MPVTogglePause <SID>MPVTogglePause
inoremap <silent> <SID>MPVTogglePause <Cmd>silent call <SID>MPVTogglePause()<CR>

" MPVGetTime function
imap `t <Plug>MPVGetTime
inoremap <script> <Plug>MPVGetTime <SID>MPVGetTime
inoremap <expr> <silent> <SID>MPVGetTime <SID>MPVGetTime()

" MPVChangeSpeed (faster)
nmap `. <Plug>MPVFaster
nnoremap <script> <Plug>MPVFaster <SID>MPVFaster
nnoremap <silent> <SID>MPVFaster <Cmd>silent call <SID>MPVChangeSpeed("faster")<CR>
imap `. <Plug>MPVFaster
inoremap <script> <Plug>MPVFaster <SID>MPVFaster
inoremap <silent> <SID>MPVFaster <Cmd>silent call <SID>MPVChangeSpeed("faster")<CR>

" MPVChangeSpeed (slower)
nmap `, <Plug>MPVSlower
nnoremap <script> <Plug>MPVSlower <SID>MPVSlower
nnoremap <silent> <SID>MPVSlower <Cmd>silent call <SID>MPVChangeSpeed("slower")<CR>
imap `, <Plug>MPVSlower
inoremap <script> <Plug>MPVSlower <SID>MPVSlower
inoremap <silent> <SID>MPVSlower <Cmd>silent call <SID>MPVChangeSpeed("slower")<CR>

" MPVChangeSpeed (reset)
nmap `= <Plug>MPVReset
nnoremap <script> <Plug>MPVReset <SID>MPVReset
nnoremap <silent> <SID>MPVReset <Cmd>silent call <SID>MPVChangeSpeed("reset")<CR>
imap `= <Plug>MPVReset
inoremap <script> <Plug>MPVReset <SID>MPVReset
inoremap <silent> <SID>MPVReset <Cmd>silent call <SID>MPVChangeSpeed("reset")<CR>

" MPVSeek (forward 10 seconds)
nmap `j <Plug>MPVSeekF1
nnoremap <script> <Plug>MPVSeekF1 <SID>MPVSeekF1
nnoremap <silent> <SID>MPVSeekF1 <Cmd>silent call <SID>MPVSeek(10)<CR>
imap `j <Plug>MPVSeekF1
inoremap <script> <Plug>MPVSeekF1 <SID>MPVSeekF1
inoremap <silent> <SID>MPVSeekF1 <Cmd>silent call <SID>MPVSeek(10)<CR>

" MPVSeek (forward 60 seconds)
nmap `k <Plug>MPVSeekF2
nnoremap <script> <Plug>MPVSeekF2 <SID>MPVSeekF2
nnoremap <silent> <SID>MPVSeekF2 <Cmd>silent call <SID>MPVSeek(60)<CR>
imap `k <Plug>MPVSeekF2
inoremap <script> <Plug>MPVSeekF2 <SID>MPVSeekF2
inoremap <silent> <SID>MPVSeekF2 <Cmd>silent call <SID>MPVSeek(60)<CR>

" MPVSeek (forward 300 seconds)
nmap `l <Plug>MPVSeekF3
nnoremap <script> <Plug>MPVSeekF3 <SID>MPVSeekF3
nnoremap <silent> <SID>MPVSeekF3 <Cmd>silent call <SID>MPVSeek(300)<CR>
imap `l <Plug>MPVSeekF3
inoremap <script> <Plug>MPVSeekF3 <SID>MPVSeekF3
inoremap <silent> <SID>MPVSeekF3 <Cmd>silent call <SID>MPVSeek(300)<CR>

" MPVSeek (back 10 seconds)
nmap `u <Plug>MPVSeekB1
nnoremap <script> <Plug>MPVSeekB1 <SID>MPVSeekB1
nnoremap <silent> <SID>MPVSeekB1 <Cmd>silent call <SID>MPVSeek(-10)<CR>
imap `u <Plug>MPVSeekB1
inoremap <script> <Plug>MPVSeekB1 <SID>MPVSeekB1
inoremap <silent> <SID>MPVSeekB1 <Cmd>silent call <SID>MPVSeek(-10)<CR>

" MPVSeek (back 60 seconds)
nmap `i <Plug>MPVSeekB2
nnoremap <script> <Plug>MPVSeekB2 <SID>MPVSeekB2
nnoremap <silent> <SID>MPVSeekB2 <Cmd>silent call <SID>MPVSeek(-60)<CR>
imap `i <Plug>MPVSeekB2
inoremap <script> <Plug>MPVSeekB2 <SID>MPVSeekB2
inoremap <silent> <SID>MPVSeekB2 <Cmd>silent call <SID>MPVSeek(-60)<CR>

" MPVSeek (back 300 seconds)
nmap `o <Plug>MPVSeekB3
nnoremap <script> <Plug>MPVSeekB3 <SID>MPVSeekB3
nnoremap <silent> <SID>MPVSeekB3 <Cmd>silent call <SID>MPVSeek(-300)<CR>
imap `o <Plug>MPVSeekB3
inoremap <script> <Plug>MPVSeekB3 <SID>MPVSeekB3
inoremap <silent> <SID>MPVSeekB3 <Cmd>silent call <SID>MPVSeek(-300)<CR>

" nnoremap <silent> ;s :call <SID>MPVSeek(30)<CR>
" nnoremap <silent> ;d :call <SID>MPVSeek(60)<CR>
" nnoremap <silent> ;f :call <SID>MPVSeek(300)<CR>
" nnoremap <silent> ;h :call <SID>MPVSeek(-10)<CR>
" nnoremap <silent> ;j :call <SID>MPVSeek(-30)<CR>
" nnoremap <silent> ;k :call <SID>MPVSeek(-60)<CR>
" nnoremap <silent> ;l :call <SID>MPVSeek(-300)<CR>
" nnoremap <silent> ;; :call <SID>MPVSeek(g:mpv_last_seek_time)<CR>

" inoremap <silent> ;1 :call <SID>MPVSeek(10)<CR>
" inoremap <silent> ;2 :call <SID>MPVSeek(30)<CR>
" inoremap <silent> ;3 :call <SID>MPVSeek(60)<CR>
" inoremap <silent> ;4 :call <SID>MPVSeek(300)<CR>
" inoremap <silent> ;! :call <SID>MPVSeek(-10)<CR>
" inoremap <silent> ;@ :call <SID>MPVSeek(-30)<CR>
" inoremap <silent> ;# :call <SID>MPVSeek(-60)<CR>
" inoremap <silent> ;$ :call <SID>MPVSeek(-300)<CR>
" inoremap <silent> ;; :call <SID>MPVSeek(g:mpv_last_seek_time)<CR>
" " ---------------------------------------------
" " END MAPPINGS

