local function get_visual(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
{
  -- IF STATEMENT
  s({trig = "iff", snippetType="autosnippet"},
    fmta(
      [[
      if (<>) {
          <>
      }
      ]],
      { 
        i(1),
        d(2, get_visual)
      }
    ),
    {condition = line_begin}
  ),
  -- FOR LOOP
  s({trig = "fll", snippetType="autosnippet"},
    fmta(
      [[
      for (<>) {
          <>
      }
      ]],
      { 
        i(1),
        d(2, get_visual)
      }
    ),
    {condition = line_begin}
  ),
  -- WHILE LOOP
  s({trig = "wll", snippetType="autosnippet"},
    fmta(
      [[
      while (<>) {
          <>
      }
      ]],
      { 
        i(1),
        d(2, get_visual)
      }
    ),
    {condition = line_begin}
  ),
  -- SWITCH STATEMENT
  s({trig = "sc", snippetType="autosnippet"},
    fmta(
      [[
      switch (<>) {
          case <>: {
              <>
          }<>
          default: {
              <>
          }
      }
      ]],
      { 
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
      }
    ),
    {condition = line_begin}
  ),
  -- SWITCH CASE
  s({trig = "cs", snippetType="autosnippet"},
    fmta(
      [[
        case <>: {
            <>
        }
      ]],
      { 
        i(1),
        d(2, get_visual),
      }
    ),
    {condition = line_begin}
  ),
}
