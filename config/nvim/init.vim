" to use Lua configurations in nvim/lua/config.lua
" lua require('config') somewhere inside init.vim

" Basic configuration settings
" -----------------------------------------------
set nocompatible			    " use vim and not vi
set encoding=utf-8
syntax enable				      " enable syntax highlighting
set wrap linebreak        " wrap long lines and break lines at words
set number				        " shows line numbers
set cursorline            " highlight current line
set ruler	  			        " shows cursor position in current line
set showcmd				        " shows partially typed commands
set nohlsearch				    " don't highlight search results
set noincsearch				    " don't jump to search results as search string is being typed
set autowriteall          " write current buffer when moving buffers
filetype on				        " enable filetype detection
filetype plugin on		    " load file-specific plugins
filetype indent on		    " load file-specific indentation
colorscheme darcula       " set colorscheme
let mapleader = " "
" ---------------------------------------------


" OS detection
" ---------------------------------------------
if !exists("g:os_current")
  if system('uname -s') == "Linux\n"
    let g:os_current = "Linux"
  elseif system('uname -s') == "Darwin\n"
    let g:os_current = "Darwin"
  else
    echom "Error: the current operating system won't support all of my Vim configurations."
    let g:os_current = "Other"
  endif
endif
" ---------------------------------------------


" Set Python provider
" ---------------------------------------------
if g:os_current == "Linux"
  let g:python3_host_prog = '/usr/local/bin/python3'
elseif g:os_current == "Darwin"
  let g:python3_host_prog = '/usr/local/bin/python3'
else
endif
" ---------------------------------------------


" Insert mode mappings
" ---------------------------------------------
" Delete character to the right of the cursor
inoremap <C-K> <Right><BS>
" <C-E> to delete word to the right of cursor (converse of <C-W>)
inoremap <C-E> <C-O>dw
" <C-D> (control+D) to delete line to the right of cursor (converse of <C-U>)
inoremap <C-D> <C-O>D
" ---------------------------------------------


" BEGIN COPY-PASTE COMMANDS
" ---------------------------------------------
if g:os_current == "Linux"
  set clipboard=unnamedplus
elseif g:os_current == "Darwin"
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" Make Y work like D or C (not vi compatible)
noremap Y y$

" stop cc and x from overwriting default register
nnoremap cc "_cc
nnoremap x "_x

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
" ---------------------------------------------
" END COPY-PASTE COMMANDS


" BEGIN NAVIGATION
" ---------------------------------------------
" useful for jumping to end of nested snippets
" the silly jump to the line start via ^ is a hack to ensure cursor exits a possible UltiSnips snippet scope
inoremap <C-L> <ESC>^$a

" mappings for navigating wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap I g^i

" navigate to line start and end from home row
" note that this overrides H and L to move the cursor to page top and page bottom
noremap H g^
noremap L g$

" Center cursor after various movements
" noremap n nzz
" noremap N Nzz
noremap '' ''zz
noremap <C-O> <C-O>zz
noremap <C-I> <C-I>zz
noremap <C-]> <C-]>zz
noremap <C-D> <C-D>zz
noremap <C-U> <C-U>zz

" mappings for faster split window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" mappings for navigating buffers
noremap <leader>b :bnext<CR>
noremap <leader>B :bprevious<CR>
" ---------------------------------------------
" END NAVIGATION


inoremap <expr> <BS> <SID>DeletePairedDelimeter()
function! s:DeletePairedDelimeter() abort
  " adapted from https://vi.stackexchange.com/a/24763

  " First checks if the cursor as at line start or line end
  " ...For reasons I haven't figured out, adding these separate cases
  " ...fixes a problem with the original solution, which would
  " ...delete the first character in a line when typing <BS> at line start
  " ...or move the line below up when when typing <BS> at line start
  if col(".") == col("^") + 1 || col(".") == col("$")
    return "\<BS>"
  else
    " get characters on either side of cursor
    let pair = getline('.')[col('.')-2 : col('.')-1]
    echom pair
    " check if cursor is placed inside a paired delimeter
    if stridx('""''''()[]<>{}``', pair) % 2 == 0
      " deletes paired delimiter
      return "\<Right>\<BS>\<BS>"
    else  " cursor was not between paired delimiters
      " normal functionality
      return "\<BS>"
    endif
  endif
endfunction


" BEGIN MISCELLANEOUS
" ---------------------------------------------
" For easy macro playback; note that this overrides entering Ex mode with Q
nnoremap Q @q

" disable automatic commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  

" close folds with zf
nnoremap zf zc

" global substitute
nnoremap <leader>s :%s/
vnoremap <leader>s :s/

" set filetype
nnoremap <leader>f :set filetype=

" Source my spelling configurations.
" Important: make sure call mapleader before sourcing my_spell,
" so that my_spell mappings use the correct leader key.
source ~/.config/nvim/personal/spell/my_spell.vim
" ---------------------------------------------
" END MISCELLANEOUS


" BEGIN PLUGIN CONFIGURATION
" ---------------------------------------------
" UltiSnips Snippet keys
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "jk"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

nnoremap <leader>U :call UltiSnips#RefreshSnippets()<CR>

" AsyncRun and AsyncTaks
let g:asyncrun_open = 8      " automatically open QuickFix menu with the given number of rows for use with AsyncRun
noremap <silent><leader>q :call asyncrun#stop('')<cr>
noremap <silent><leader>r :AsyncTask file-run-compile<cr>
noremap <silent><leader>p :AsyncTask project-build-serve<cr>
" ---------------------------------------------
" END PLUGIN CONFIGURATION
