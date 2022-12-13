require('toggletasks').setup { }
require('telescope').load_extension('toggletasks')

local discovery = require('toggletasks.discovery')
local function spawn_by_name(name)
  local tasks = discovery.tasks():filter(function(task)
    return task.config.name == name
  end)

  if #tasks > 0 then -- if any matching tasks found
    tasks[1]:spawn()
    tasks[1].term:open()
  else
    print("No matching task with name", name)
  end
end

-- Open Telescope task picker
vim.keymap.set('n', '<space>ts', require('telescope').extensions.toggletasks.spawn)

-- Run "Project" task
vim.keymap.set('n', '<Leader>tp', function() spawn_by_name("Project") end)
