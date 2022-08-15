" Configuration related to navigation through a file and between buffers

" Useful for jumping to the end of nested snippets.
" The silly jump to the line start via ^ is a hack to ensure cursor exits 
" a possible UltiSnips snippet scope
inoremap <C-L> <ESC>^$a

" Mappings for navigating wrapped lines
nnoremap j gj
nnoremap k gk

" Reach start of line a bit more conveniently
nnoremap 0 ^
nnoremap I ^i

" Stay inside current paragraph
noremap } j}k
noremap { k{j

" Navigate to line start and end from home row; note that this overrides 
" H and L to move the cursor to page top and page bottom.
noremap H g^
noremap L g$

" Center cursor in screen after various movements
noremap '' ''zz
noremap <C-O> <C-O>zz
noremap <C-I> <C-I>zz
noremap <C-]> <C-]>zz
noremap <C-D> <C-D>zz
noremap <C-U> <C-U>zz

" Mappings for faster split window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Mappings for navigating buffers
noremap <leader>b :bnext<CR>
noremap <leader>B :bprevious<CR>
