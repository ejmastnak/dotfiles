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

    -- Groceries
    s({trig="EFG", snippetType="autosnippet"},
      {t("Expenses:EUR:OpEx:Food:Groceries")},
      {condition = line_begin}
    ),
    -- Home Upkeep
    s({trig="EIH", snippetType="autosnippet"},
      {t("Expenses:EUR:OpEx:Infrastructure:HomeUpkeep")},
      {condition = line_begin}
    ),
    -- Bicycle
    s({trig="ETB", snippetType="autosnippet"},
      {t("Expenses:EUR:OpEx:Transportation:Bicycle")},
      {condition = line_begin}
    ),
    -- Phone
    s({trig="EIP", snippetType="autosnippet"},
      {t("Expenses:EUR:OpEx:Infrastructure:Phone")},
      {condition = line_begin}
    ),
    -- Internet
    s({trig="EII", snippetType="autosnippet"},
      {t("Expenses:EUR:OpEx:Infrastructure:Internet")},
      {condition = line_begin}
    ),
    -- Home improvements
    s({trig="EAH", snippetType="autosnippet"},
      {t("Expenses:EUR:AdHoc:HomeImprovements")},
      {condition = line_begin}
    ),
    -- Entertaining
    s({trig="EAE", snippetType="autosnippet"},
      {t("Expenses:EUR:AdHoc:Entertaining")},
      {condition = line_begin}
    ),
    -- Dance
    s({trig="ELD", snippetType="autosnippet"},
      {t("Expenses:EUR:Leisure:Dance")},
      {condition = line_begin}
    ),
    -- Unknown
    s({trig="EUU", snippetType="autosnippet"},
      {t("Expenses:EUR:AdHoc:Unknown")},
      {condition = line_begin}
    ),
    -- Kitchen
    s({trig="EGK", snippetType="autosnippet"},
      {t("Expenses:EUR:Goods:Kitchen")},
      {condition = line_begin}
    ),
    -- Tools
    s({trig="EGT", snippetType="autosnippet"},
      {t("Expenses:EUR:Goods:Tools")},
      {condition = line_begin}
    ),

    -- Bolha Income
    s({trig="IEB", snippetType="autosnippet"},
      {t("Income:EUR:Bolha")},
      {condition = line_begin}
    ),



    -- Pano Income
    s({trig="IUP", snippetType="autosnippet"},
      {t("Income:USD:Tutoring:Pano")},
      {condition = line_begin}
    ),


    s({trig = "--", snippetType="autosnippet"},
      {t('; --------------------------------------------- ;')},
      {condition = line_begin}
    ),
}

