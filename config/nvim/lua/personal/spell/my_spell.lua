vim.opt.spelllang = 'en'

vim.b.SPELL_SLOVENE = false

function ToggleSloveneSpell()
  if vim.b.SPELL_SLOVENE then  -- if Slovene spelling is on, turn it off
    vim.opt.spelllang:append('en')
    vim.opt.spelllang:remove('sl')
    vim.b.SPELL_SLOVENE = false
  else -- if Slovene spelling is off, turn it on
    vim.opt.spelllang:append('sl')
    vim.opt.spelllang:remove('en')
    vim.b.SPELL_SLOVENE = true
  end
end

vim.keymap.set('n', '<Leader>zz', '<Cmd>set spell!<CR>')
vim.keymap.set('n', '<Leader>zs', ToggleSloveneSpell)
