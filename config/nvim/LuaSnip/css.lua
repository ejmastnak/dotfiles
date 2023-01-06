local function get_visual(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- CURLY BRACES
    s({trig = "([^;])df", wordTrig=false, regTrig=true; snippetType="autosnippet"},
      fmta(
        [[
        <>{
          <>
        }
        ]],
        { 
          f( function(_, snip) return snip.captures[1] end ),
          i(0)
        }
      )
    ),
    -- BACKGROUND COLOR
    s({trig = ";bc", snippetType="autosnippet"},
      fmta(
        [[
          background-color: <>;
        ]],
        { i(0) }
      )
    ),
    -- DISPLAY
    s({trig = ";dd", snippetType="autosnippet"},
      fmta(
        [[
          display: <>;
        ]],
        { i(0) }
      )
    ),
    -- DISPLAY FLEX
    s({trig = ";df", snippetType="autosnippet"},
      { t("display: flex;") }
    ),
    -- JUSTIFY CONTENT
    s({trig = ";jc", snippetType="autosnippet"},
      fmta(
        [[
          justify-content: <>;
        ]],
        { i(0) }
      )
    ),
    -- ALIGN ITEMS
    s({trig = ";ai", snippetType="autosnippet"},
      fmta(
        [[
          align-items: <>;
        ]],
        { i(0) }
      )
    ),
    -- WIDTH
    s({trig = ";w", snippetType="autosnippet"},
      fmta(
        [[
          width: <>;
        ]],
        { i(0) }
      )
    ),
  }
