local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
{
  -- void
  s({trig = "vv", snippetType="autosnippet"},
    fmt(
      [[ void ]],
      { }
    )
  ),
  -- int
  s({trig = ";ii", snippetType="autosnippet"},
    fmt(
      [[
      int {}
      ]],
      { 
        i(1),
      }
    )
  ),
  -- size_t
  s({trig = ";ss", snippetType="autosnippet"},
    fmt(
      [[
      size_t {}
      ]],
      { 
        i(1),
      }
    )
  ),
  -- unsigned
  s({trig = ";uu", snippetType="autosnippet"},
    fmt(
      [[
      unsigned {}
      ]],
      { 
        i(1),
      }
    )
  ),
  -- unsigned int
  s({trig = ";ui", snippetType="autosnippet"},
    fmt(
      [[
      unsigned int {}
      ]],
      { 
        i(1),
      }
    )
  ),
  -- long
  s({trig = ";ll", snippetType="autosnippet"},
    fmt(
      [[
      long {}
      ]],
      { 
        i(1),
      }
    )
  ),
  -- unsigned long
  s({trig = ";ul", snippetType="autosnippet"},
    fmt(
      [[
      unsigned long {}
      ]],
      { 
        i(1),
      }
    )
  ),
  -- float
  s({trig = ";f", snippetType="autosnippet"},
    fmt(
      [[
      float {}
      ]],
      { 
        i(1),
      }
    )
  ),
  -- double
  s({trig = ";d", snippetType="autosnippet"},
    fmt(
      [[
      double {}
      ]],
      { 
        i(1),
      }
    )
  ),
  -- void
  s({trig = ";v", snippetType="autosnippet"},
    fmt(
      [[
      (void) {}
      ]],
      { 
        i(1),
      }
    )
  ),
}
