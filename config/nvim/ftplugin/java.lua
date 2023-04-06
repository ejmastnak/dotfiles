-- indentation settings
vim.bo.expandtab   = true
vim.bo.autoindent  = true
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4

vim.keymap.set('', '<Leader>c', '<Cmd>update<CR><Cmd>TermExec cmd="javac %"<CR>')
vim.keymap.set('', '<Leader>r', '<Cmd>update<CR><Cmd>TermExec cmd="java -cp %:h %:r"<CR>')

local jdtls_config = {
    cmd = {'/home/ej/.local/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', '.root'}, { upward = true })[1]),
  on_attach = function(client)
    vim.diagnostic.disable(0)
    require('illuminate').on_attach(client)
  end,
}
require('jdtls').start_or_attach(jdtls_config)
