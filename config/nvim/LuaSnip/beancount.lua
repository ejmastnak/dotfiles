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
    -- OPEN ACCOUNT
    s({trig="oo", snippetType="autosnippet"},
      fmta(
        [[
        <>-<>-<> open <> <>
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
    -- INCLUDE
    s({trig="inn", snippetType="autosnippet"},
      {t("include ")},
      {condition = line_begin}
    ),
    -- PUSHTAG
    s({trig="ps", snippetType="autosnippet"},
      {t("pushtag #")},
      {condition = line_begin}
    ),
    -- POPTAG
    s({trig="pp", snippetType="autosnippet"},
      {t("poptag #")},
      {condition = line_begin}
    ),

    -- ACCOUNT SCHOOLS FIRST CHECKING
    s({trig=";sf", snippetType="autosnippet"},
      {t("Assets:SchoolsFirst:Checking")},
      {condition = line_begin}
    ),
    -- ACCOUNT VANGUARD MONEY MARKET
    s({trig=";vm", snippetType="autosnippet"},
      {t("Assets:Vanguard:MoneyMarket")},
      {condition = line_begin}
    ),
    -- ACCOUNT NLB CHECKING
    s({trig=";n", snippetType="autosnippet"},
      {t("Assets:NLB:Checking")},
      {condition = line_begin}
    ),
    -- ACCOUNT ABANKA CHECKING
    s({trig=";a", snippetType="autosnippet"},
      {t("Assets:Abanka:Checking")},
      {condition = line_begin}
    ),
    -- CASH USD
    s({trig=";cu", snippetType="autosnippet"},
      {t("Assets:USD:Cash")},
      {condition = line_begin}
    ),
    -- CASH EUR
    s({trig=";ce", snippetType="autosnippet"},
      {t("Assets:EUR:Cash")},
      {condition = line_begin}
    ),
    -- EXPENSE MARKET
    s({trig=";m", snippetType="autosnippet"},
      {t("Expenses:EUR:Food:Market")},
      {condition = line_begin}
    ),
    -- EXPENSE GROCERIES
    s({trig=";g", snippetType="autosnippet"},
      {t("Expenses:EUR:Food:Groceries")},
      {condition = line_begin}
    ),
    -- EXPENSE UNKNOWN
    s({trig=";u", snippetType="autosnippet"},
      {t("Expenses:EUR:Other:Unknown")},
      {condition = line_begin}
    ),

    s({trig = "--", snippetType="autosnippet"},
      {t('; --------------------------------------------- ;')},
      {condition = line_begin}
    ),
}

