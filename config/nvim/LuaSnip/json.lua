local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- New key/value pair, with choice of quoted value
    s({trig = ">>", snippetType="autosnippet"},
      fmt(
        [[
           "{}": {},
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t('"'), i(1), t('"')}), i(1)}),
        }
      ),
      {condition = line_begin}
    ),


  }


    

    
