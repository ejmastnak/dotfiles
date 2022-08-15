local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
-- Manually triggered snippets
{},
-- Autotriggered snippets
{
  s({trig="env"},
    fmta(
      [[
        \begin{<>}<>
            <>
        \end{<>}
        <>
      ]],
      {
        
        i(1, ""),
        c(2, {t(""), sn(nil, {t("{"), i(1, ""), t("}")})}),
        i(3, ""),
        rep(1),
        i(0),
      }
    )),
  -- fraction
  s({trig = "([^%l])ff", regTrig = true, wordTrig = false},
    fmta(
      "<>\\frac{<>}{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
        i(2, ""),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- inline math
  s({trig = "([^%l])mm", regTrig = true, wordTrig = false},
    fmta(
      "<>$<>$",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
    })),
  -- inline math on new line
  s({trig = "^mm", regTrig = true, wordTrig = false},
    fmta(
      "$<>$",
      {
        i(1, ""),
    })),
}
