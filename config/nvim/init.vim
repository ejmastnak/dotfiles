" Basic configuration settings
" -----------------------------------------------
set nocompatible			    " use vim and not vi
filetype plugin on		    " load file-specific plugins
filetype indent on		    " load file-specific indentation
filetype on				        " enable filetype detection
set encoding=utf-8
syntax enable				      " enable syntax highlighting
set wrap linebreak        " wrap long lines and break lines at words
set number				        " shows line numbers
set cursorline            " highlight current line
set ruler	  			        " shows cursor position in current line
set showcmd				        " shows partially typed commands
set nohlsearch				    " don't highlight search results
set noincsearch				    " don't jump to search results as search string is being typed
set signcolumn=no         " disable LSP diagnostic symbols in left column
set noshowmode            " disable in favor of lualine/lightline statusline
set nofoldenable          " don't fold text by default when opening files
set autowrite             " write current buffer when moving buffers
syntax enable             " enable syntax highlighting
let mapleader = " "
" ---------------------------------------------

if (has("termguicolors"))
  set termguicolors
endif

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
  let g:python3_host_prog = '/usr/bin/python3'
elseif g:os_current == "Darwin"
  let g:python3_host_prog = '/usr/local/bin/python3'
else
endif
" ---------------------------------------------

" Specify plugins using Vim-Plug
" ---------------------------------------------
call plug#begin('~/dotfiles/config/nvim/plugged')
" Global
Plug 'junegunn/vim-plug'
Plug 'SirVer/ultisnips'
" Plug 'L3MON4D3/LuaSnip'
Plug 'ggandor/lightspeed.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'numToStr/Comment.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'kylechui/nvim-surround'

" Filetype-specific
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'lervag/vimtex'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'RRethy/vim-illuminate'
Plug 'nvim-Treesitter/nvim-Treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
call plug#end()
" ---------------------------------------------

colorscheme nord

source ~/.config/nvim/personal/init/copy-paste.vim
source ~/.config/nvim/personal/init/navigation.vim
source ~/.config/nvim/personal/init/insert-mode.vim
source ~/.config/nvim/personal/init/indent.vim
source ~/.config/nvim/personal/init/projects.vim

" Plugin configuration
source ~/.config/nvim/personal/plugins/dispatch.vim
source ~/.config/nvim/personal/plugins/comment.vim
source ~/.config/nvim/personal/plugins/easy-align.vim
source ~/.config/nvim/personal/plugins/fzf.vim
source ~/.config/nvim/personal/plugins/lualine.vim
source ~/.config/nvim/personal/plugins/lightspeed.vim
source ~/.config/nvim/personal/plugins/rooter.vim
source ~/.config/nvim/personal/plugins/mpv.vim
source ~/.config/nvim/personal/plugins/nvim-surround.vim
source ~/.config/nvim/personal/plugins/ultisnips.vim
" source ~/.config/nvim/personal/plugins/luasnip.vim

" LSP congifuration
source ~/.config/nvim/personal/lsp/lsp-config.vim
source ~/.config/nvim/personal/lsp/illuminate.vim
source ~/.config/nvim/personal/lsp/treesitter.vim

" BEGIN MISCELLANEOUS
" ---------------------------------------------
" Easier write command
nnoremap <leader>w <Cmd>write<CR>

" Write and quit if applicable, quit otherwise
function! s:VimQuit() abort
  try
    wq
  catch
    q!
  endtry
endfunction
noremap <leader>q <Cmd>call <SID>VimQuit()<CR>

" Easier edit command
nnoremap <leader>e :edit 

" Easier help command
nnoremap <leader>h :help 

" For easy macro playback; note that this overrides entering Ex mode with Q
nnoremap Q @q

" Easily pull up the Git command (for use with vim-fugitive)
nnoremap <leader>g :Git 

" disable automatic commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  

" close folds with zf
nnoremap zf zc
set foldmethod=marker

" equivalent of `:join` or `J` for lines above cursor
nnoremap K kdd$

" global substitute
nnoremap <leader>s :%s/
vnoremap <leader>s :s/

" " set filetype
" nnoremap <leader>f :set filetype=

" Source my spelling configurations.
" Important: make sure to set mapleader before sourcing my_spell,
" so that my_spell mappings use the correct leader key.
source ~/.config/nvim/personal/spell/my_spell.vim

" Set swap file directory
set directory^=$HOME/.config/nvim/swap//
" ---------------------------------------------
" END MISCELLANEOUS

" Return to Terminal in normal mode
tnoremap <Esc> <C-\><C-n>
" Start insert mode when entering terminal buffers
" autocmd BufEnter term://* startinsert

" Window navigation
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-j> <C-\><C-n><C-w>j
