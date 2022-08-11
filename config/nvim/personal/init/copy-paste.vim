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
vnoremap p P
