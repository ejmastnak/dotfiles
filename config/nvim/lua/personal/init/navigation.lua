-- Configuration for navigation through a file and between buffers

-- Useful for jumping to the end of the current line in insert mode
vim.keymap.set('i', '<C-L>', '<ESC>A')

-- Mappings for navigating wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Reach start of line a bit more conveniently
vim.keymap.set('', '0', '^')
vim.keymap.set('n', 'I', '^i')
vim.keymap.set('', '^', '0')

-- Eaiser access to % for match-it / match-up
vim.keymap.set('', 'gj', '<Plug>(matchup-%)')
vim.keymap.set('', 'gJ', '2<Plug>(matchup-%)')

-- Navigate to line start and end from home row; note that this overrides 
-- H and L to move the cursor to page top and page bottom.
vim.keymap.set('', 'H', 'g^')
vim.keymap.set('', 'L', 'g$')

-- Center cursor in screen after various movements
vim.keymap.set('', '<C-O>', '<C-O>zz')
vim.keymap.set('', '<C-I>', '<C-I>zz')
vim.keymap.set('', '<C-]>', '<C-]>zz')
vim.keymap.set('', '<C-D>', '<C-D>zz')
vim.keymap.set('', '<C-U>', '<C-U>zz')

-- Mappings for faster split window navigation
vim.keymap.set('', '<C-h>', '<C-w>h')
vim.keymap.set('', '<C-j>', '<C-w>j')
vim.keymap.set('', '<C-k>', '<C-w>k')
vim.keymap.set('', '<C-l>', '<C-w>l')

-- Mappings for navigating buffers
vim.keymap.set('', '<Leader>b', '<Cmd>bnext<CR>')
vim.keymap.set('', '<Leader>B', '<Cmd>bprevious<CR>')

-- Mappings for navigating QuickFix entries
vim.keymap.set('', '<Leader>cc', '<Cmd>cc<CR>')
vim.keymap.set('', '<Leader>cn', '<Cmd>cnext<CR>')
vim.keymap.set('', '<Leader>cp', '<Cmd>cprevious<CR>')
vim.keymap.set('', '<Leader>co', '<Cmd>copen<CR>')
vim.keymap.set('', '<Leader>cq', '<Cmd>cclose<CR>')
