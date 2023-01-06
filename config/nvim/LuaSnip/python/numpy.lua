local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- NP.LOADTXT
    s({trig="nlt", snippetType="autosnippet"},
      fmta(
        [[
          np.loadtxt(<>)
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
  }
