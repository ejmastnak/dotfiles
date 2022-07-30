" Configuration related to copying and pasting
if g:os_current == "Linux"
  set clipboard=unnamedplus
elseif g:os_current == "Darwin"
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" Make Y work like D or C (not vi compatible)
noremap Y y$

" stop cc, x, and s from overwriting default register
nnoremap cc "_cc
nnoremap x "_x
nnoremap X "_X

" Paste in visual mode without overwriting default register
vnoremap <silent> p "_d:call <SID>VisualPasteWithoutOverwrite()<CR>

function! s:VisualPasteWithoutOverwrite() abort
  " pastes with p for cursor on line end
  " pastes with P otherwise
  if col(".") + 1 == col("$")
    "actually there are special cases.
    " this is a hack but it covers my use cases nicely
    " problem: pasting while having selected the content of paired delimiters
    " at line end e.g. (some selected content)$ would result in
    " ()pasted content$ instead of (pasted content)$
    " so I check for e.g. ), }, ]
    let s:last_character_on_line = strpart(getline('.'), col('.') - 1, 1)
    if s:last_character_on_line == ')'
          \ || s:last_character_on_line == ']'
          \ || s:last_character_on_line == '}' 
          \ || s:last_character_on_line == '>' 
          \ || s:last_character_on_line == '"' 
          \ || s:last_character_on_line == "\'"
      normal P
    else
      normal p
    endif
  else
    normal P
  endif
endfunction
