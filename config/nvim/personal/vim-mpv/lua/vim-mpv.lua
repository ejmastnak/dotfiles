local M = {}

-- TODO
-- vim.g.mpv_socket should be a table of strings
-- mpvterm should generalize to mpvterms, a table of references terminals
-- I should have a get_mpvterm function
-- I need to clarify my API

-- Construct socket name as "/tmp/mpvsocket" .. server .. "_" .. idx
-- Access server with vim.v.servername
--   It looks like /run/user/1000/nvim.2403806.0
--   Probably match '%.%d+%.'
-- Access buffer number with vim.fn.bufnr("%")

-- Okay what functions are exposed

--   open()
--   play_word_under_cursor()
--   play(file_to_play, opts, socket)
--   close()  ALL FILES
--   toggle_play_pause()  ALL FILES
--   get_current_time()
--   insert_timestamp(on_new_line)
--   goto_timestamp()
--   playlist_parallel()

-- Global variables
vim.g.mpv_playing = false
vim.g.mpv_max_parallel_tracks = 5
vim.g.mpv_socket = "/tmp/mpvsocket"

-- ToggleTerm Terminal object
local Terminal = require('toggleterm.terminal').Terminal
local Job = require('plenary.job')

-- Remove lingering socket files when exiting Vim
vim.api.nvim_create_autocmd({"VimLeave"}, {
  pattern = {"*"},
  callback = function() require('vim-mpv')._cleanup_socket() end,
})

local mpvterm = Terminal:new({
  cmd = "",  -- Specified by user when called function `mpv_start`

  -- Function to run on opening the terminal
  on_open = function(term)
    vim.g.mpv_playing = true
  end,

  -- Function to run when terminal process exits
  on_exit = function(term, job_num, exit_code, proc_name)
    vim.g.mpv_playing = false
  end,
})

local function _validate_file_to_play(file_to_play)
  -- Check if file exists and is readable
  if vim.fn.filereadable(file_to_play) == 1 then
    return true
  else
    return false
  end
end

-- Checks if a connection to mpv is currently active
local function _mpv_active()
  return vim.g.mpv_playing
end

-- Writes the inputted string `command` to mpv socket using `socat`.
-- Returns mpv's response, if any, as a Lua table.
local function _write_command_to_mpv_socket(command)
  local input_pipe = vim.loop.new_pipe(true)
  local stdout_response = {}
  local job = Job:new {
    writer = input_pipe,
    command = "socat",
    args = { "-", vim.g.mpv_socket },
    on_stdout = function(_, line)
      table.insert(stdout_response, line)
    end,
  }

  job:start()
  input_pipe:write(command)
  input_pipe:close()
  job:shutdown()

  return stdout_response
end

-- Meant to clean up mpv socket before exiting Vim
-- to avoid cluttering /tmp with lingering sockets
function M._cleanup_socket()
  if vim.fn.filereadable(vim.g.mpv_socket) == 1 then
    vim.fn.delete(vim.g.mpv_socket)
  end
end

-- Interface function through which a user chooses a file to open with mpv
function M.open()
  if _mpv_active() then
    print("A connection to mpv is already active. Close it before opening a new file.")
    do return end
  end

  if vim.fn.exists("g.mpv_file_to_auto_open") == 1 then
    M.play(vim.g.mpv_file_to_auto_open)
  else
    local fname
    vim.ui.input({ prompt = 'File to open: ', completion = 'file' }, function(input) fname = input end)
    if fname then  -- check if user cancelled input
      M.play(fname)
    end
  end
end

-- Interprets the current Vim WORD under the cursor as the path to a track
-- and attempts to play the track
function M.play_word_under_cursor()
  -- This can be a one-liner because validation is performed in M.play()
  M.play(vim.fn.expand('<cWORD>'))
end

-- Begins playback of an inputted file with mpv
function M.play(file_to_play, opts, socket)

  -- If connection is already active, open terminal
  if _mpv_active() then
    print("A connection to mpv is already active. Close it before opening a new file.")
    do return end
  end

  -- Validate file to open
  if not _validate_file_to_play(file_to_play) then
    print("File", file_to_play, "does not exist or is not readable. Exiting.")
    do return end
  end

  -- Empty opts string if not options passed
  if not opts then opts = "" end

  mpvterm.cmd = "mpv " .. opts .. " " .. file_to_play .. " --input-ipc-server=" .. vim.g.mpv_socket

  -- Open terminal and spawn `cmd`
  mpvterm:toggle()
  vim.cmd("wincmd k")  -- Return cursor to original window
  vim.cmd("stopinsert")  -- Return to normal mode

  -- Refocus Vim window (e.g. when opening videos)
  if vim.fn.exists("g:vim_window_id") ~= 0 then
    -- Give window manager time to recognize focus moved to video window
    vim.cmd('sleep 400m')
    vim.fn.system("xdotool windowfocus " .. vim.g.vim_window_id)
    vim.cmd('redraw!')
  end

end

-- Closes current connection to mpv and shuts down associated terminal
function M.close()
  if _mpv_active() then
    mpvterm:shutdown()
  end
end

-- Closes current connection to mpv and shuts down associated terminal
function M.toggle_play_pause()

  if not _mpv_active() then
    print("No active connection to mpv.")
    do return end
  end

  -- Executes the following piped shell command
  -- echo '{"command": ["cycle", "pause"]}' | socat - ${mpv_socket}

  _write_command_to_mpv_socket('{"command": ["cycle", "pause"]}\n')
end

-- Returns the a table holding the hour, minute, second, and microsecond
-- values of the current playback position for use in hh:mm:ss timestamps.
function M.get_current_time()

  if not _mpv_active() then
    print("No active connection to mpv.")
    do return end
  end

  -- Executes the following piped shell command
  -- echo '{ "command": ["get_property", "playback-time"] }' | socat - ${mpv_socket}
  -- And saves the resulting stdout response to the table `stdout_response`
  -- The table is a 1-element table holding a string of the form
  -- {"data":7.136230,"request_id":0,"error":"success"}
  -- The `data` field is expressed in seconds.

  local stdout_response = _write_command_to_mpv_socket('{ "command": ["get_property", "playback-time"] }\n')

  if #stdout_response ~= 1 then
    print("Error extracting timestamp. Aborting.")
    do return end
  end

  -- E.g. extract the '67.136230' from a result of the form
  -- '{"data":67.136230,"request_id":0,"error":"success"}'
  local seconds = string.match(stdout_response[1], "%d+%.%d+")

  -- E.g. split string "67.136230" into the numbers
  -- 67 (seconds), 136 (milliseconds) and 230 (microseconds)
  local s = tonumber(string.match(seconds, "(%d+)%."))
  local ms = tonumber(string.match(seconds, "%.(%d%d%d)%d%d%d"))
  local us = tonumber(string.match(seconds, "%.%d%d%d(%d%d%d)"))

  -- Extract hours, minutes, seconds for hh:mm:ss format
  local hh = math.floor(tonumber(seconds) / 3600)
  local mm = math.floor(tonumber(seconds) / 60) % 60
  local ss = s % 60

  return {hh, mm, ss, ms, us}
end

-- Inserts timestamp of current playback position in hh:mm:ss.mss
-- format at the current cursor position in Neovim
-- Inserts timestamp on a new line if on_new_line == true 
function M.insert_timestamp(on_new_line)

  if not _mpv_active() then
    print("No active connection to mpv.")
    do return end
  end

  local time = M.get_current_time()
  hh = time[1]
  mm = time[2]
  ss = time[3]
  ms = time[4]
  timestamp = string.format("%02d:%02d:%02d.%03d", hh, mm, ss, ms)

  -- Column and line number of current cursor position
  local l,c = unpack(vim.api.nvim_win_get_cursor(0))
  -- String content of current line
  local line = vim.api.nvim_get_current_line()
  -- Insert timestamp at current cursor position in current line
  local new_line = line:sub(0, c) .. timestamp .. line:sub(c + 1)

  if on_new_line then
    vim.api.nvim_buf_set_lines(0, l-1, l, true, {new_line, ""})
    vim.api.nvim_feedkeys('j', 'n', false)
  else
    vim.api.nvim_set_current_line(new_line)
  end
end

function M.goto_timestamp()

  if not _mpv_active() then
    print("No active connection to mpv.")
    do return end
  end

  -- Capture Vim WORD under cursor (:help WORD)
  local cWORD = vim.fn.expand('<cWORD>')

  -- Try matching word under cursor to (hh:mm:ss.mmm), (hh:mm:ss), (mm:ss)
  local timestamp_patterns = {'%d%d:%d%d:%d%d.%d%d%d', '%d%d:%d%d:%d%d', '%d%d:%d%d'}

  local match = nil
  for _, pattern in ipairs(timestamp_patterns) do
    match = string.match(cWORD, pattern)
    if match then  -- (If `match` is not `nil`, i.e. a timestamp pattern was matched)
      -- Seeks to matching timestamp with a shell command of the form...
      -- echo '{ "command": ["seek", "00:42:42", "absolute", "exact"] }' | socat - ${mpv_socket}
      _write_command_to_mpv_socket('{ "command": ["seek", "' .. match .. '", "absolute", "exact"] }\n')
      do return end  -- Exit loop through `timestamp_patterns`
    end
  end
end

-- Play all tracks in file in parallel
function M.playlist_parallel()

  -- Get number of lines in current buffer
  local line_count = vim.api.nvim_buf_line_count(0)

  if line_count > vim.g.mpv_max_parallel_tracks then
    print("Too many tracks in file!")
    do return end
  end

  -- Get all lines in current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, line_count, true)

  for _, line in ipairs(lines) do
    -- Split comma-delimited line into track and volume
    track, volume = line:match("([^,]+),([^,]+)")

    -- Effectively ignores comments, blank lines, etc.
    if (track and volume) then
      -- Call `play()` and pass the opt string "--volume=" .. volume

      -- TODO
      -- I need to store a reference to each track to be able to pause it later
      -- This means I need to create a separate socket for each track

      -- The only other thing is be able to pause and play all tracks.

      -- The appropriate choice here is to store sockets in a table.
    end
  end

  print(vim.v.servername)

end

return M
