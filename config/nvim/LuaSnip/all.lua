local helpers = require('personal.luasnip-helper-funcs')
local get_date = helpers.get_ISO_8601_date
local get_visual = helpers.get_visual

return
  {
    -- Paired parentheses
    s({trig="(", wordTrig = false, snippetType="autosnippet"},
      {
        t("("),
        d(1, get_visual),
        t(")"),
      }),
    -- Paired curly braces
    s({trig="{", wordTrig = false, snippetType="autosnippet"},
      {
        t("{"),
        d(1, get_visual),
        t("}"),
      }),
    -- Paired square brackets
    s({trig="[", wordTrig = false, snippetType="autosnippet"},
      {
        t("["),
        d(1, get_visual),
        t("]"),
      }),
    -- Paired back ticks
    -- s({trig="([^`])sd", snippetType="autosnippet", regTrig=true, wordTrig=false},
    s({trig="sd", snippetType="autosnippet"},
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("`"),
        d(1, get_visual),
        t("`"),
      }),
    -- Paired double quotes
    s({trig='([ `=%{%(%[])"', regTrig = true, wordTrig = false, snippetType="autosnippet"},
      {
        f( function(_, snip) return snip.captures[1] end ),
        t('"'),
        d(1, get_visual),
        t('"'),
      }),
    -- Paired single quotes
    s({trig="([ =%{%(%[])'", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("'"),
        d(1, get_visual),
        t("'"),
      }),
    -- Today's date in YYYY-MM-DD (ISO 8601) format
    s({trig = "i"},
    {f(get_date)}
    -- {f(get_ISO_8601_date)}
    ),
  }
