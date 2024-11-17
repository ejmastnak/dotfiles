require('luasnip').filetype_extend("apy", {"markdown"})

local helpers = require('personal.luasnip-helper-funcs')
local get_date = helpers.get_ISO_8601_date
local get_visual = helpers.get_visual

return
  {
    -- New note
    s({trig = "NN", snippetType="autosnippet"},
      fmt(
        [[
          # Note

          ## Front
          {}

          ## Back
          {}
        ]],
        { i(1), i(2), }
      ),
      {condition=line_begin}
    ),
  }
