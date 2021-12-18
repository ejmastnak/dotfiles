" Settings for working with LilyPond documents
" Only load this plugin if another ftplugin is not yet loaded for this buffer
if exists("b:did_ftplugin")
  finish                      " exit if did_ftplugin is true
endif
let b:did_ftplugin = 1       " plugin is loaded 

compiler mylilypond          " load my user-defined lilypond compiler plugin

" setting indentation
setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Make vim-commentary use % for comments 
setlocal commentstring=%\ %s

" Compilation
nnoremap <leader>r :Make<CR>

" Forward show
" ---------------------------------------------
function! s:LilyForwardShow() abort
  " Use Neovim's async jobstart API
  call jobstart("zathura " . expand('%:r') . ".pdf")
  redraw!
endfunction

" LilyForwardShow mapping
nmap <leader>v <Plug>LilyForwardShow
noremap <script> <Plug>LilyForwardShow <SID>LilyForwardShow
noremap <SID>LilyForwardShow :call <SID>LilyForwardShow()<CR>
" ------------------------------------------- "
