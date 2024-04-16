-- Override some Pytonsense key mappings

vim.g.is_pythonsense_suppress_object_keymaps = 1
vim.g.is_pythonsense_suppress_motion_keymaps = 1

-- Class motion
vim.keymap.set('', ']c', '<Plug>(PythonsenseStartOfNextPythonClass)', {buffer = true})
vim.keymap.set('', ']C', '<Plug>(PythonsenseEndOfPythonClass)', {buffer = true})
vim.keymap.set('', '[c', '<Plug>(PythonsenseStartOfPythonClass)', {buffer = true})
vim.keymap.set('', '[C', '<Plug>(PythonsenseEndOfPreviousPythonClass)', {buffer = true})

-- Function motion
vim.keymap.set('', ']m', '<Plug>(PythonsenseStartOfNextPythonFunction)', {buffer = true})
vim.keymap.set('', ']M', '<Plug>(PythonsenseEndOfPythonFunction)', {buffer = true})
vim.keymap.set('', '[m', '<Plug>(PythonsenseStartOfPythonFunction)', {buffer = true})
vim.keymap.set('', '[m', '<Plug>(PythonsenseEndOfPreviousPythonFunction)', {buffer = true})
vim.keymap.set('', ']]', '<Plug>(PythonsenseStartOfNextPythonFunction)', {buffer = true})
vim.keymap.set('', '][', '<Plug>(PythonsenseEndOfPythonFunction)', {buffer = true})
vim.keymap.set('', '[[', '<Plug>(PythonsenseStartOfPythonFunction)', {buffer = true})
vim.keymap.set('', '[]', '<Plug>(PythonsenseEndOfPreviousPythonFunction)', {buffer = true})

-- Class text object
vim.keymap.set({'x', 'o'}, 'aC', '<Plug>(PythonsenseOuterClassTextObject)', {buffer = true, remap = true})
vim.keymap.set({'x', 'o'}, 'iC', '<Plug>(PythonsenseInnerClassTextObject)', {buffer = true, remap = true})

-- Function text object
vim.keymap.set({'x', 'o'}, 'af', '<Plug>(PythonsenseOuterFunctionTextObject)', {buffer = true, remap = true})
vim.keymap.set({'x', 'o'}, 'if', '<Plug>(PythonsenseInnerFunctionTextObject)', {buffer = true, remap = true})

-- Doc string comment text object
vim.keymap.set({'x', 'o'}, 'ac', '<Plug>(PythonsenseOuterDocStringTextObject)', {buffer = true, remap = true})
vim.keymap.set({'x', 'o'}, 'ic', '<Plug>(PythonsenseInnerDocStringTextObject)', {buffer = true, remap = true})
