-- About this file: my simple roll-your-own settings for managing and building
-- multi-file projects. Uses the Rooter plugin to find the project root
-- directory, searches for a '.vim-project-command' file in the root directory,
-- and executes it if it exists.
-- Dependencies: Rooter and ToggleTerm

vim.g.project_command_file = '.vim-project-command'

function ProjectRunJob()
  vim.cmd('Rooter')

  -- Check that project job exists and is executable
  if (vim.fn.filereadable("./" .. vim.g.project_command_file) == 0) or (vim.fn.executable("./" .. vim.g.project_command_file) == 0) then
    print('Project job file does not exist, is not readable, or is not executable.')
    return
  end

  -- Run project command; pass it the current file name
  vim.cmd('2TermExec size=8 cmd="./' .. vim.g.project_command_file .. ' %"')
end

vim.keymap.set('', '<Leader>p', ProjectRunJob, {desc = 'Run project-wide command file.'})
