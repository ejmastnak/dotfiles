local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Variable
    s({trig = "vv", snippetType="autosnippet"},
      fmt(
        [[
        $({})
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- Compile a C file
    s({trig = "cc", snippetType="autosnippet"},
      fmt(
        [[
        {}: {}.c
        	gcc {}.c -o {}
        ]],
        {
          i(1),
          rep(1),
          rep(1),
          rep(1),
        }
      ),
      {condition = line_begin}
    ),
    -- Compile a C file with PortAudio
    s({trig = "cpa", snippetType="autosnippet"},
      fmt(
        [[
        {}: {}.c
        	gcc {}.c -lm -lportaudio -o {}
        ]],
        {
          i(1),
          rep(1),
          rep(1),
          rep(1),
        }
      ),
      {condition = line_begin}
    ),
  }
