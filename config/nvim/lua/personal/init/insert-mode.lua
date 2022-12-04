-- Configuration related to copying and pasting

-- Delete character to the right of the cursor
vim.keymap.set('i', '<C-K>', '<Right><BS>')
-- <C-E> to delete word to the right of cursor (converse of <C-W>)
vim.keymap.set('i', '<C-E>', '<C-O>dw')
-- <C-D> (control+D) to delete line to the right of cursor (converse of <C-U>)
vim.keymap.set('i', '<C-D>', '<C-O>D')

-- Adapted from https://vi.stackexchange.com/a/24763
function DeletePairedDelimiter()
  -- First check if the cursor as at line start or line end.
  -- For reasons I haven't figured out, adding these separate cases
  -- fixes a problem with the original solution, which would
  -- delete the first character in a line when typing <BS> at line start
  -- or move the line below upward when when typing <BS> at line start.
  if vim.fn.col('.') == vim.fn.col('^') + 1 or vim.fn.col('.') == vim.fn.col('$') then
    return '<BS>'
  else
    -- Get characters on either side of cursor
    local pair = string.sub(vim.fn.getline('.'), vim.fn.col('.')-1, vim.fn.col('.'))
    -- Check if cursor is placed inside a paired delimiter
    if math.fmod(vim.fn.stridx('\'\'""()[]$$<>{}``', pair), 2) == 0 then
      return "<Right><BS><BS>" -- Deletes paired delimiter
    else
      return "<BS>" -- A normal press of the backspace key
    end
  end
end

vim.keymap.set('i', '<BS>', DeletePairedDelimiter, {expr = true, desc="Delete paired delimiters surround the cursor in insert mode."})
