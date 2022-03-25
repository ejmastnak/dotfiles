" This is a hack to force the catch-all %-G%.%# that removes unmatched lines
" There are two problems:
" 1. vim-dispatch intentionally removes the original catch-all; see https://github.com/tpope/vim-dispatch/issues/76#issuecomment-50210286
" 2. Vim "helpfully" filters out errorformat duplicates; setting errorformat+=%-G%.%#
"    wouldn't work, so errorformat+=%-G%.%#,. where the appending ,. does nothing is
"    a hack to force in an extra catchall.
setlocal errorformat+=%-G%.%#,.


" ABOUT: a small modification to the nord colorscheme to bring down 
" the intensity of the bright white (from nord6 to nord5) used for delimiters.
" Original motivation: screen recordings for my vim-latex tutorial.
let s:nord4_gui = "#D8DEE9"
let s:nord5_gui = "#E5E9F0"
let s:nord6_gui = "#ECEFF4"
let s:nord6_term = "15"

function! s:hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . substitute(a:attr, "undercurl", s:underline, "")
  endif
  if a:guisp != ""
    exec "hi " . a:group . " guisp=" . a:guisp
  endif
endfunction

call s:hi("Delimiter", s:nord5_gui, "", s:nord6_term, "", "", "")
call s:hi("Delimiter", s:nord4_gui, "", s:nord6_term, "", "", "")
