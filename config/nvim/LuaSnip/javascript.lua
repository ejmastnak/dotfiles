local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- ALERT
    s({trig = "all", snippetType="autosnippet"},
      fmta(
        [[
        alert(<>);
        ]],
        {
          d(1, get_visual)
        }
      )
    ),
    -- LOG TO CONSOLE
    s({trig = "log", snippetType="autosnippet"},
      fmta(
        [[
        console.log(<>);
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
  }





