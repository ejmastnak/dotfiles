local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- BLOCK FOR BASE TEMPLATES
    s({trig="bblock"},
      fmt(
        [[
          {{ block "[]" [] }}
            []
          {{ end }}
        ]],
        {
          i(1),
          i(2, '.'),
          d(3, get_visual),
        },
        { delimiters = "[]" }
      ),
      {condition = line_begin}
    ),
    -- DEFINE BLOCK FOR OVERRIDING BASE BLOCK
    s({trig="dblock"},
      fmt(
        [[
          {{ define "[]" }}
            []
          {{ end }}
        ]],
        {
          i(1),
          d(2, get_visual),
        },
        { delimiters = "[]" }
      ),
      {condition = line_begin}
    ),
  }




