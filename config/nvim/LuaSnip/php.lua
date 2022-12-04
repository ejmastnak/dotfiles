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
    s({trig = "cc", snippetType="autosnippet"},
      fmta(
        [[
        /**
         *  <>
         */
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
  }
