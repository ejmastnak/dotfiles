set spelllang=en

let b:SPELL_SLOVENE = 0

" function for toggling Slovene spelling
" ------------------------------
function! s:ToggleSloveneSpell() abort
  if b:SPELL_SLOVENE  " turn off Slovene
    set spelllang+=en
    set spelllang-=sl
    let b:SPELL_SLOVENE = 0
  else  " turn on Slovene
    set spelllang+=sl
    set spelllang-=en
    let b:SPELL_SLOVENE = 1
  endif
endfunction
" ------------------------------


" Key mappings
" ------------------------------
nnoremap <leader>z :set spell!<CR>

" mapping for ToggleSloveneSpell()
map <leader>ts <Plug>ToggleSloveneSpell
nnoremap <silent> <Plug>ToggleSloveneSpell :call <SID>ToggleSloveneSpell()<CR>
