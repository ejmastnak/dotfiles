-- Basic configuration settings
-- -----------------------------------------------
vim.opt.number       = true   -- show line numbers
vim.opt.cursorline   = true   -- highlight current line
vim.opt.ruler        = true	  -- shows cursor position in current line
vim.opt.showcmd      = true	  -- shows partially typed commands
vim.opt.hlsearch     = false  -- don't highlight search results
vim.opt.incsearch    = false  -- don't jump to search results as search string is being typed
vim.opt.showmode     = false  -- disable in favor of lualine/lightline statusline
vim.opt.foldenable   = false  -- don't fold text by default when opening files
vim.opt.foldmethod   = "marker"
vim.opt.autowriteall = true   -- write current buffer when moving buffers
vim.opt.wrap         = true   -- wrap long lines
vim.opt.linebreak    = true   -- break lines at words
vim.opt.signcolumn   = "no"   -- disable LSP diagnostic symbols in left column

vim.keymap.set('', '<Space>', '<NOP>')
vim.g.mapleader = " "  -- set global leader key

if vim.fn.has('termguicolors') == 1 then
  vim.opt.termguicolors = true
end

-- OS detection
if vim.fn.exists("g:os_current") == 0 then
  if vim.fn.system('uname -s') == "Linux\n" then
    vim.g.os_current = "Linux"
  elseif vim.fn.system('uname -s') == "Darwin\n" then
    vim.g.os_current = "Darwin"
  else
    print("Error: the current operating system won't support all of my Vim configurations.")
    vim.g.os_current = "Other"
  end
end

if vim.g.os_current == "Linux" then
  vim.g.python3_host_prog = "/usr/bin/python3"
elseif vim.g.os_current == "Darwin" then
  vim.g.python3_host_prog = "/usr/local/bin/python3"
end

-- Load plugins with vim-plug
-- --------------------------------------------- --
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'junegunn/vim-plug'
Plug 'shaunsingh/nord.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'numToStr/Comment.nvim'
Plug('kylechui/nvim-surround', {tag = '*'})
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'coachshea/vim-textobj-markdown'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'akinsho/toggleterm.nvim'
Plug 'jedrzejboczar/toggletasks.nvim'
Plug 'airblade/vim-rooter'
Plug 'L3MON4D3/LuaSnip'
Plug 'brenoprata10/nvim-highlight-colors'

-- Filetype-specific
Plug('iamcco/markdown-preview.nvim', {['do'] = 'cd app && yarn install'})
Plug 'mzlogin/vim-markdown-toc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'lervag/vimtex'
Plug 'nathangrigg/vim-beancount'

-- LSP-like
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', {['tag'] = '0.1.0'})
Plug 'RRethy/vim-illuminate'
Plug('nvim-Treesitter/nvim-Treesitter', {['do'] = ':TSUpdate'})
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

-- Local plugins
Plug '~/.config/nvim/personal/vim-mpv'
Plug '~/.config/nvim/personal/vim-beanquery'

vim.call('plug#end')
-- --------------------------------------------- --
-- End loading plugins

vim.cmd('colorscheme nord')

-- Personal configuration
require('personal/init/copy-paste')
require('personal/init/navigation')
require('personal/init/indent')
require('personal/init/insert-mode')
require('personal/init/projects')

-- Plugin configuration
require('plugins/lspconfig')
require('plugins/treesitter')
require('plugins/illuminate')
require('plugins/Comment')
require('plugins/dispatch')
require('plugins/easy-align')
require('plugins/telescope')
require('plugins/nvim-surround')
require('plugins/toggleterm')
require('plugins/toggletasks')
require('plugins/rooter')
require('plugins/lualine')
require('plugins/lightspeed')
require('plugins/LuaSnip')

-- LSP config
require('lsp/lsp')

-- BEGIN MISCELLANEOUS
-- --------------------------------------------- "
-- Easier write command
vim.keymap.set('n', '<Leader>w', '<Cmd>write<CR>')

-- Change default fold command
vim.keymap.set('n', 'zf', 'zc')
vim.keymap.set('n', 'zc', 'zf')

-- Easier edit command
vim.keymap.set('n', '<Leader>e', ':edit ')

-- Easier help command
vim.keymap.set('n', '<Leader>h', ':help ')

-- For easy macro playback; note that this overrides entering Ex mode with Q
vim.keymap.set('n', 'Q', '@q')

-- Easily pull up the Git command (for use with vim-fugitive)
vim.keymap.set('n', '<Leader>g', ':Git ')

-- Rough analog of `:join` or `J` for lines above cursor
vim.keymap.set('n', 'K', 'kdd$')

-- Move current line up and down
-- See https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
vim.keymap.set('n', '<C-S-j>', '<Cmd>move .+1<CR>')
vim.keymap.set('n', '<C-S-k>', '<Cmd>move .-2<CR>')

-- Move selected lines up and down
-- See https://stackoverflow.com/questions/41084565/moving-multiple-lines-in-vim-visual-mode
vim.cmd([[
xnoremap <C-S-j> :m'>+<CR>gv=gv
xnoremap <C-S-k>  :m-2<CR>gv=gv
]])


-- Global substitute
vim.keymap.set('n', '<Leader>s', ':%s/')
vim.keymap.set('v', '<Leader>s', ':s/')
-- Search/replace current word under cursor
vim.cmd([[
nnoremap <expr> <C-s> ':%s/' . expand('<cword>') . '/'
]])

-- Set swap file directory to within Vim directory
vim.opt.directory:prepend(os.getenv("HOME") .. "/.config/nvim/swap//")

-- Use escape to return to normal mode in a Neovim terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Easier window navigation in terminals
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')

-- Disable automatic comment continuation on next line
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
})

-- Write and quit if possible/applicable, force quit otherwise
vim.keymap.set('n', '<Leader>q',
  function()
    local success, result = pcall(vim.cmd, 'wq')
    if not success then
      vim.cmd('q!')
    end
  end,
  {desc = 'Write and quit if possible/applicable, force quit otherwise.'})

-- Save and close all buffers
vim.keymap.set('n', '<Leader>Q', '<Cmd>wqa<CR>')

-- Sort text by paragraph (useful for e.g. for Beancount files)
-- Implements https://stackoverflow.com/a/24099468
vim.api.nvim_create_user_command('SortByParagraph', ':%s/\\(.\\+\\)\\n/\\1@/ | :sort | :%s/@/\\r/g', {})

-- Source my spelling configurations.
-- Important: make sure to set mapleader before sourcing my_spell,
-- so that my_spell mappings use the correct leader key.
require('personal/spell/my_spell')

-- Use `d` (delimiter) for targets.vim block text objects
-- (Requires targets.vim)
vim.cmd[[
autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'd': {'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}]},
    \ })
]]


vim.keymap.set('', '<Leader>hc', '<Cmd>HighlightColorsToggle<CR>')

-- END MISCELLANEOUS
