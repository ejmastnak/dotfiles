local function get_visual(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

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
      {t("Assets:Cash:USD")},
      {condition = line_begin}
    ),
    -- CASH EUR
    s({trig=";ce", snippetType="autosnippet"},
      {t("Assets:Cash:EUR")},
      {condition = line_begin}
    ),
    -- EXPENSE MARKET
    s({trig=";m", snippetType="autosnippet"},
      {t("Expenses:Food:Market:EUR")},
      {condition = line_begin}
    ),
    -- EXPENSE GROCERIES
    s({trig=";g", snippetType="autosnippet"},
      {t("Expenses:Food:Groceries:EUR")},
      {condition = line_begin}
    ),
    -- EXPENSE UNKNOWN
    s({trig=";u", snippetType="autosnippet"},
      {t("Expenses:Other:Unknown:EUR")},
      {condition = line_begin}
    ),

}

