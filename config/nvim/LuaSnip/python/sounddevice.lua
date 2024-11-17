local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Query default output device
    s({trig="sdqod", snippetType="autosnippet"},
      {
        t("device = sd.query_devices(device=None, kind='output')")
      },
      {condition = line_begin}
    ),
    -- Get index of audio device
    s({trig="sdid", snippetType="autosnippet"},
      {
        t("device['index']")
      }
    ),
    -- Get default sample rate of audio device
    s({trig="sdfs", snippetType="autosnippet"},
      {
        t("device['default_samplerate']")
      }
    ),
    -- Callback function for audio output
    s({trig="sdoc", snippetType="autosnippet"},
      fmt(
        [[
          def callback(outdata, frames, time, status):
              if status:
                  print(status, file=sys.stderr)
              {}
        ]],
        {
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    -- Start output stream with a context manager
    s({trig="sdwos", snippetType="autosnippet"},
      fmt(
        [[
          with sd.OutputStream(device={}, channels={}, callback={}, samplerate={}):
              print("Press Return to quit.")
              input()
        ]],
        {
          i(1, "device_idx"),
          i(2, "channels"),
          i(3, "callback"),
          i(4, "fs"),
        }
      ),
      {condition = line_begin}
    ),


  }
