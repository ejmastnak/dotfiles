local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- HEADER
    -- s({trig="h([123456])", regTrig=true, wordTrig=false, snippetType="autosnippet"},
    --   fmt(
    --     [[
    --       <h{}{}>{}</h{}>
    --     ]],
    --     {
    --       f( function(_, snip) return snip.captures[1] end ),
    --       i(1),
    --       d(2, get_visual),
    --       f( function(_, snip) return snip.captures[1] end ),
    --     }
    --   ),
    --   {condition = line_begin}
    -- ),
  }
