require('toggletasks').setup { }
require('telescope').load_extension('toggletasks')

local discovery = require('toggletasks.discovery')

local function spawn_by_name(name)
  local tasks = discovery.tasks():filter(function(task)
    return task.config.name == name
  end)

  if #tasks > 0 then
    -- Span task with matching name
    tasks[1]:spawn()
    tasks[1].term:open()
  else
    print("No matching task with name", name)
  end
end

local function spawn_tasks_with_tag(tag)
  local tasks = discovery.tasks():filter(function(task)
    return vim.tbl_contains(task.config.tags or {}, tag)
  end)

  if #tasks > 0 then
    -- Span all tasks with matching tag
    for _, task in pairs(tasks) do
      task:spawn()
      task.term:open()
    end
  else
    print("No matching tasks with tag", tag)
  end

end

-- Open Telescope task picker
vim.keymap.set('n', '<space>ts', require('telescope').extensions.toggletasks.spawn)

-- Run all tasks with #the project tag
vim.keymap.set('n', '<Leader>tp', function()
  vim.cmd("Rooter")  -- switch to project root directory
  spawn_tasks_with_tag("project") 
  vim.cmd("wincmd k")  -- Return cursor to original window
  vim.cmd("stopinsert")  -- Return to normal mode
end)

-- Run all tasks with the #compile tag
vim.keymap.set('n', '<Leader>to', function()
  vim.cmd("Rooter")  -- switch to project root directory
  spawn_tasks_with_tag("compile") 
  vim.cmd("wincmd k")  -- Return cursor to original window
  vim.cmd("stopinsert")  -- Return to normal mode
end)

-- Run all tasks with the #view tag
vim.keymap.set('n', '<Leader>ti', function()
  vim.cmd("Rooter")  -- switch to project root directory
  spawn_tasks_with_tag("view") 
  vim.cmd("wincmd k")  -- Return cursor to original window
  vim.cmd("stopinsert")  -- Return to normal mode
end)
