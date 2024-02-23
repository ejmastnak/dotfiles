local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Background blue
    s({trig = "bbb", snippetType="autosnippet"},
      {t('bg-blue-100')}
    ),
  }
