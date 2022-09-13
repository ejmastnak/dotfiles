require('Comment').setup({
  ---LHS of toggle mappings in NORMAL + VISUAL mode
  ---@type table
  toggler = {
      ---Line-comment toggle keymap
      line = 'gll',
      ---Block-comment toggle keymap
      block = 'gcc',
  },

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  opleader = {
      ---Line-comment keymap
      line = 'gl',
      ---Block-comment keymap
      block = 'gc',
  },

  ---LHS of extra mappings
  ---@type table
  extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
  },
})
