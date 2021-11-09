set spelllang=en

let b:SPELL_SLOVENE = 0

" function for toggling Slovene spelling
" ------------------------------
if !exists("s:ToggleSloveneSpell") 
  function s:ToggleSloveneSpell()
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
endif
" ------------------------------


" Key mappings
" ------------------------------
nnoremap <leader>z :set spell!<CR>

" mapping for ToggleSloveneSpell()
if !hasmapto('<Plug>ToggleSloveneSpell', 'nvo')
  map <unique> <buffer> <leader>ts <Plug>ToggleSloveneSpell
  nnoremap <unique> <silent> <buffer> <Plug>ToggleSloveneSpell :call <SID>ToggleSloveneSpell()<CR>
endif

" ------------------------------
