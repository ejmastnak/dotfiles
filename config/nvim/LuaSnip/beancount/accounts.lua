local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- EUR expense accounts
    s({trig="aee", snippetType="autosnippet"},
      {t("Expenses:EUR:")},
      {condition = line_begin}
    ),
    -- Groceries
    s({trig=":grr", snippetType="autosnippet", wordTrig=false},
      {t(":Food:Groceries")}
    ),
    -- Internet
    s({trig=":intt", snippetType="autosnippet", wordTrig=false},
      {t(":Internet")}
    ),
    -- Public transport
    s({trig=":ptt", snippetType="autosnippet", wordTrig=false},
      {t(":Transportation:PublicTransport")}
    ),
    -- Home upkeep
    s({trig=":huu", snippetType="autosnippet", wordTrig=false},
      {t(":HomeUpkeep")}
    ),
    -- Phone
    s({trig=":phh", snippetType="autosnippet", wordTrig=false},
      {t(":Phone")}
    ),
    -- UPN fees
    s({trig=":upn", snippetType="autosnippet", wordTrig=false},
      {t(":UpnFees")}
    ),
    -- ZZZ Insurance
    s({trig=":zzz", snippetType="autosnippet", wordTrig=false},
      {t(":ZzzInsurance")}
    ),
    -- Library
    s({trig=":libb", snippetType="autosnippet", wordTrig=false},
      {t(":Leisure:Library")}
    ),
    -- Uknown AdHoc expense
    s({trig=":ahu", snippetType="autosnippet", wordTrig=false},
      {t(":AdHoc:Unknown")}
    ),
    -- TV47 property tax
    s({trig=":tvpt", snippetType="autosnippet", wordTrig=false},
      {t(":TV47:PropertyTax")}
    ),

  }

