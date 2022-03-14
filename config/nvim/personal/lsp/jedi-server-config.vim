" Currently not actually sourced from anywhere

" use <C-Space> for Jedi omnicompletion
inoremap <silent> <buffer> <C-Space> <C-x><C-o>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set completeopt=longest,menuone
