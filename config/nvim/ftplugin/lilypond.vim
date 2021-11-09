" Settings for working with LilyPond documents
" Only load this plugin if another ftplugin is not yet loaded for this buffer
if exists("b:did_ftplugin")
  finish                      " exit if did_ftplugin is true
endif
let b:did_ftplugin = 1       " plugin is loaded 

Let s:forward_show_script = "$HOME/.config/nvim/personal/forward-show.sh"

let s:displayline_command = "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g"

" setting indentation
set expandtab
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

" BEGIN FUNCTIONS
" ------------------------------------------- "
function! lilypond#compile() abort
  update
  if g:os_current == "Linux"
    execute "AsyncRun lilypond $(VIM_FILENAME)"
  elseif g:os_current == "Darwin"
    execute "AsyncRun lilypond -dno-point-and-click $(VIM_FILENAME)"
  else
    echo "Error: unsupported operating system."
  endif
endfunction

function! lilypond#forward_show() abort
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
noremap <Plug>LilyPondCompile :call lilypond#compile()<cr>
nmap <leader>r <Plug>LilyPondCompile

noremap <Plug>LilyPondForwardShow :call lilypond#forward_show()<cr>
nmap <leader>v <Plug>LilyPondForwardShow
" ------------------------------------------- "
" END MAPPINGS
