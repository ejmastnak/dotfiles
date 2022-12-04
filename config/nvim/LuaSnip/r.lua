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
    -- FUNCTION DEFINITION
    s({trig="ff", snippetType="autosnippet"},
      fmta(
        [[
      <> <<- function(<>) {
          <>
      }
      ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- SLEEP
    s({trig="ss", snippetType="autosnippet"},
      fmta(
        [[
        Sys.sleep(<>)
        ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- PRINT
    s({trig="pp", snippetType="autosnippet"},
      fmta(
        [[
        print(<>)
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- CAT
    s({trig="cc", snippetType="autosnippet"},
      fmta(
        [[
        cat(<>)
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- CURLY BRACES
    s({trig = "df", snippetType="autosnippet"},
      fmta(
        [[
      {
        <>
      }
      ]],
        { i(1) }
      )
    ),
  }
