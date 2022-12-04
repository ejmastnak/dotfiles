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
    s({trig = "doc"},
      fmt(
        [[
        # NAME
        # 		{} - {}
        # 
        # SYNOPSIS
        # 		{} {}
        ]],
        {
          i(1, "name"),
          i(2, "description"),
          rep(1),
          i(3, "usage"),
        }
      ),
      {condition = line_begin}
    ),
    s({trig = "fl", snippetType="autosnippet"},
      fmt(
        [[
        for {} in {}; do
          {}
        done
        ]],
        {
          i(1),
          i(2),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    s({trig = "ext"},
      fmta(
        [[
        ${<>%.<>}
        ]],
        {
          i(1, "var"),
          i(2, "ext"),
        }
      )
    ),
  }
