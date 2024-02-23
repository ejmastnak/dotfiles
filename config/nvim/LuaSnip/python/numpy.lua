local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- np.loadtxt()
    s({trig="nplt", snippetType="autosnippet"},
      fmta(
        [[
          np.loadtxt(<>, delimiter='<>')
        ]],
        {
          i(1, 'fname'),
          i(2, ',')
        }
      )
    ),
    -- np.savetxt()
    s({trig="npst", snippetType="autosnippet"},
      fmta(
        [[
          np.savetxt(<>, <>, delimiter='<>')
        ]],
        {
          i(1, 'fname'),
          i(2, 'ndarray'),
          i(3, ',')
        }
      )
    ),
  }
