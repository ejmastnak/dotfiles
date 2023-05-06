local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- For ID3 tag files
    s({trig = "tt", snippetType="autosnippet"},
      fmt(
        [[
          title: {}
          artist: {}
          album: {}
          year: {}
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(4),
        }
      ),
      {condition = line_begin}
    ),
  }
