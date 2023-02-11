local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- BACKGROUND COLOR
    s({trig = ";bc", snippetType="autosnippet"},
      fmta(
        [[
          background-color: <>;
        ]],
        { i(0) }
      )
    ),
    -- DISPLAY
    s({trig = ";dd", snippetType="autosnippet"},
      fmta(
        [[
          display: <>;
        ]],
        { i(0) }
      )
    ),
    -- JUSTIFY CONTENT
    s({trig = ";jc", snippetType="autosnippet"},
      fmta(
        [[
          justify-content: <>;
        ]],
        { i(0) }
      )
    ),
    -- ALIGN ITEMS
    s({trig = ";ai", snippetType="autosnippet"},
      fmta(
        [[
          align-items: <>;
        ]],
        { i(0) }
      )
    ),
    -- WIDTH
    s({trig = ";w", snippetType="autosnippet"},
      fmta(
        [[
          width: <>;
        ]],
        { i(0) }
      )
    ),
  }
