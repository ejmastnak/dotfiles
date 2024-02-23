require('luasnip').filetype_extend("vue", {"html", "javascript"})

local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- useForm
    s({trig = "uff", snippetType="autosnippet"},
      fmta(
        [[
          const form = useForm({
            <>,
          });
        ]],
        { 
          i(1),
        }
      )
    ),
  }



