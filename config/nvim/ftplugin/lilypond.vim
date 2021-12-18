" Settings for working with LilyPond documents
" Only load this plugin if another ftplugin is not yet loaded for this buffer
if exists("b:did_ftplugin")
  finish                      " exit if did_ftplugin is true
endif
let b:did_ftplugin = 1       " plugin is loaded 

let s:forward_show_script = "$HOME/.config/nvim/personal/forward-show.sh"

let s:displayline_command = "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g"

" setting indentation
setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" BEGIN FUNCTIONS
" ------------------------------------------- "
function! s:LilyCompile() abort
  update
  if g:os_current == "Linux"
    execute "AsyncRun lilypond $(VIM_FILENAME)"
  elseif g:os_current == "Darwin"
    execute "AsyncRun lilypond -dno-point-and-click $(VIM_FILENAME)"
  else
    echo "Error: unsupported operating system."
  endif
endfunction

function! s:LilyForwardShow() abort
  " TLDR: AsyncRun sh forward_show_script line pdf_file lilypond_file OS_name
  execute "AsyncRun sh " . expand(s:forward_show_script) . " " .
        \ line('.') .
        \ " $(VIM_RELDIR)/$(VIM_FILENOEXT).pdf " .
        \ " $(VIM_RELDIR)/$(VIM_FILENOEXT).ly" .
        \ expand(g:os_current)
endfunction
" ------------------------------------------- "
" END FUNCTIONS


" BEGIN MAPPINGS
" ------------------------------------------- "
" LilyCompile
nmap <leader>r <Plug>LilyCompile
noremap <script> <Plug>LilyCompile <SID>LilyCompile
noremap <SID>LilyCompile :call LilyCompile()<CR>

" LilyForwardShow
nmap <leader>v <Plug>LilyForwardShow
noremap <script> <Plug>LilyForwardShow <SID>LilyForwardShow
noremap <SID>LilyForwardShow :call LilyForwardShow()<CR>
" ------------------------------------------- "
" END MAPPINGS
