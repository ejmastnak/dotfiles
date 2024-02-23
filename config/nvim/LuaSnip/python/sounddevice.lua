local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- SoundDevice (to get around sd triggering ``)
    s({trig = "SD", snippetType = "autosnippet"},
      { t("sd.") }
    ),
    -- Query index of output device
    s({trig="qod", snippetType="autosnippet"},
      fmta(
        [[
          sd.query_devices(device=<>, kind='output')
        ]],
        {
          i(1, 'None'),
        }
      ),
      {condition = line_begin}
    ),
    -- Callback function
    s({trig="cbb", snippetType="autosnippet"},
      fmta(
        [[
          def callback(outdata, frames, time, status):
              if status:
                  print(status, file=sys.stderr)
              <>
        ]],
        {
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    -- Start an output stream
    s({trig="sos", snippetType="autosnippet"},
      fmt(
        [[
          with sd.OutputStream(device={}, channels={}, callback={}, samplerate={}):
              print("Press Return to quit.")
              input()
              {}
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(4),
          i(0)
        }
      ),
      {condition = line_begin}
    ),


  }
