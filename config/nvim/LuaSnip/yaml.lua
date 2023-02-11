local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- For now bean-query snippets

return
  {
    -- AND
    s({trig = "([^%l])AA", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
        {}AND 
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
        }
      )
    ),
    -- OR
    s({trig = "([^%l])OO", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
        {}OR 
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
        }
      )
    ),
    -- AFTER (for dates)
    s({trig = "([^%l])aa", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
        {}after 
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
        }
      )
    ),
    -- BEFORE (for dates)
    s({trig = "([^%l])bb", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
        {}before 
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
        }
      )
    ),
  }
