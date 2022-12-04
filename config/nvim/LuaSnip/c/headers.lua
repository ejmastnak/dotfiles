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
  -- GENERIC HEADER INCLUDE
  s({trig = "hh", snippetType="autosnippet"},
    fmt(
      [[#include <{}.h>]],
      { 
        d(1, get_visual)
      }
    ),
    {condition = line_begin}
  ),
  -- STDIO HEADER
  s({trig = "hio", snippetType="autosnippet"},
    { t('#include <stdio.h>') },
    {condition = line_begin}
  ),
  -- STDLIB HEADER
  s({trig = "hlib", snippetType="autosnippet"},
    { t('#include <stdlib.h>') },
    {condition = line_begin}
  ),
  -- STRING HEADER
  s({trig = "hstr", snippetType="autosnippet"},
    { t('#include <string.h>') },
    {condition = line_begin}
  ),
}
