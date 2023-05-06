-- Override some Pytonsense key mappings
vim.keymap.set('', ']]', '<Plug>(PythonsenseStartOfNextPythonFunction)', {buffer = true})
vim.keymap.set('', '][', '<Plug>(PythonsenseEndOfPythonFunction)', {buffer = true})
vim.keymap.set('', '[[', '<Plug>(PythonsenseStartOfPythonFunction)', {buffer = true})
vim.keymap.set('', '[]', '<Plug>(PythonsenseEndOfPreviousPythonFunction)', {buffer = true})

-- Duplicate keybindings for function navigation
vim.keymap.set('', ']m', '<Plug>(PythonsenseStartOfNextPythonFunction)', {buffer = true})
vim.keymap.set('', ']M', '<Plug>(PythonsenseEndOfPythonFunction)', {buffer = true})
vim.keymap.set('', '[m', '<Plug>(PythonsenseStartOfPythonFunction)', {buffer = true})
vim.keymap.set('', '[M', '<Plug>(PythonsenseEndOfPreviousPythonFunction)', {buffer = true})

-- And for navigation classes
vim.keymap.set('', ']c', '<Plug>(PythonsenseStartOfNextPythonClass)', {buffer = true})
vim.keymap.set('', ']C', '<Plug>(PythonsenseEndOfPythonClass)', {buffer = true})
vim.keymap.set('', '[c', '<Plug>(PythonsenseStartOfPythonClass)', {buffer = true})
vim.keymap.set('', '[C', '<Plug>(PythonsenseEndOfPreviousPythonClass)', {buffer = true})
