local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- TRANSACTION
    s({trig="tt", snippetType="autosnippet"},
      fmta(
        [[
        <> txn "<>" "<>"
          <>
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    s({trig = "--", snippetType="autosnippet"},
      {t('; --------------------------------------------- ;')},
      {condition = line_begin}
    ),
}

