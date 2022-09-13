" Basic configuration settings
" -----------------------------------------------
lua << EOF
vim.opt.number     = true   -- show line numbers
vim.opt.cursorline = true   -- highlight current line
vim.opt.ruler      = true	  -- shows cursor position in current line
vim.opt.showcmd    = true	  -- shows partially typed commands
vim.opt.hlsearch   = false  -- don't highlight search results
vim.opt.incsearch  = false  -- don't jump to search results as search string is being typed
vim.opt.showmode   = false  -- disable in favor of lualine/lightline statusline
vim.opt.foldenable = false  -- don't fold text by default when opening files
vim.opt.foldmethod = "marker"
vim.opt.autowrite  = true   -- write current buffer when moving buffers
vim.opt.wrap       = true   -- wrap long lines
vim.opt.linebreak  = true   -- break lines at words
vim.opt.signcolumn = "no"   -- disable LSP diagnostic symbols in left column

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
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'junegunn/vim-plug'
Plug 'shaunsingh/nord.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'numToStr/Comment.nvim'
Plug('kylechui/nvim-surround', {tag = '*'})
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug('akinsho/toggleterm.nvim', {tag = '*'})
Plug 'airblade/vim-rooter'
Plug 'SirVer/ultisnips'

-- Filetype-specific
Plug('iamcco/markdown-preview.nvim', {['do'] = 'cd app && yarn install'})
Plug 'mzlogin/vim-markdown-toc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'lervag/vimtex'

-- LSP-like
Plug 'neovim/nvim-lspconfig'
Plug 'RRethy/vim-illuminate'
Plug('nvim-Treesitter/nvim-Treesitter', {['do'] = ':TSUpdate'})
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

vim.call('plug#end')

vim.cmd('colorscheme nord')
EOF

source ~/.config/nvim/personal/init/copy-paste.vim
source ~/.config/nvim/personal/init/navigation.vim
source ~/.config/nvim/personal/init/insert-mode.vim
source ~/.config/nvim/personal/init/indent.vim
source ~/.config/nvim/personal/init/projects.vim
source ~/.config/nvim/personal/lsp/lsp-config.vim

" Plugin configuration
source ~/.config/nvim/personal/plugins/lualine.vim
source ~/.config/nvim/personal/plugins/lightspeed.vim
source ~/.config/nvim/personal/plugins/comment.vim
source ~/.config/nvim/personal/plugins/nvim-surround.vim
source ~/.config/nvim/personal/plugins/easy-align.vim
source ~/.config/nvim/personal/plugins/fzf.vim
source ~/.config/nvim/personal/plugins/dispatch.vim
source ~/.config/nvim/personal/plugins/toggle-term.vim
source ~/.config/nvim/personal/plugins/rooter.vim
source ~/.config/nvim/personal/plugins/ultisnips.vim
source ~/.config/nvim/personal/lsp/illuminate.vim
source ~/.config/nvim/personal/lsp/treesitter.vim

" source ~/.config/nvim/personal/plugins/mpv.vim
" source ~/.config/nvim/personal/plugins/luasnip.vim

" BEGIN MISCELLANEOUS
" ---------------------------------------------
lua << EOF
-- Easier write command
vim.keymap.set('n', '<Leader>w', '<Cmd>write<CR>')

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

-- Global substitute
vim.keymap.set('n', '<Leader>s', ':%s/')
vim.keymap.set('v', '<Leader>s', ':s/')

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

-- Source my spelling configurations.
-- Important: make sure to set mapleader before sourcing my_spell,
-- so that my_spell mappings use the correct leader key.
require('personal/spell/my_spell')

-- END MISCELLANEOUS
EOF
