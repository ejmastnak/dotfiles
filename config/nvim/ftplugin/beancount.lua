vim.keymap.set('', '<Leader>c', '<Cmd>Make<CR>')
vim.api.nvim_set_option('foldmethod', 'marker')

local sort_script = os.getenv("HOME") .. "/Documents/basics/finances/scripts/src/sort-beancount.py"

vim.api.nvim_create_user_command('SortBeancount',
  function(opts)
    if vim.fn.filereadable(sort_script) == 1 then
      -- Sort file and reload Vim
      os.execute(sort_script .. ' ' .. vim.api.nvim_buf_get_name(0))
      vim.cmd("edit")
    else
      print("Error: could not local sorting script.")
    end
  end, {})

vim.keymap.set('', '<Leader>S', '<Cmd>SortBeancount<CR>')
