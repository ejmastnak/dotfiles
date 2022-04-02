" to use Lua configurations in nvim/lua/config.lua
" lua require('config') somewhere inside init.vim

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
set noshowmode            " disable in favor of lightline.vim's statusline
set nofoldenable          " don't fold text by default when opening files
set autowriteall          " write current buffer when moving buffers
syntax enable             " enable syntax highlighting
let mapleader = " "
" ---------------------------------------------

if (has("termguicolors"))
  set termguicolors
endif
colorscheme nord          " set colorscheme

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
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'itchyny/lightline.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'ggandor/lightspeed.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Filetype-specific
Plug 'chrisbra/csv.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'lervag/vimtex'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'RRethy/vim-illuminate'

" Email
Plug 'soywod/himalaya', {'rtp': 'vim'}
call plug#end()
" ---------------------------------------------

source ~/.config/nvim/personal/init/copy-paste.vim
source ~/.config/nvim/personal/init/navigation.vim
source ~/.config/nvim/personal/init/insert-mode.vim

" Plugin configuration
source ~/.config/nvim/personal/plugins/async-run-task.vim
source ~/.config/nvim/personal/plugins/csv.vim
source ~/.config/nvim/personal/plugins/dispatch.vim
source ~/.config/nvim/personal/plugins/easy-align.vim
source ~/.config/nvim/personal/plugins/fzf.vim
source ~/.config/nvim/personal/plugins/lightline.vim
source ~/.config/nvim/personal/plugins/lightspeed.vim
source ~/.config/nvim/personal/plugins/mpv.vim
source ~/.config/nvim/personal/plugins/UltiSnips.vim

" LSP congifuration
source ~/.config/nvim/personal/lsp/lsp-config.vim
source ~/.config/nvim/personal/lsp/illuminate.vim


" BEGIN MISCELLANEOUS
" ---------------------------------------------
" Easier write command
nnoremap <leader>w :w<CR>

" For easy macro playback; note that this overrides entering Ex mode with Q
nnoremap Q @q

" Easily pull up the Git command (for use with vim-fugitive)
nnoremap <leader>g :Git 

" disable automatic commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  

" close folds with zf
nnoremap zf zc

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
