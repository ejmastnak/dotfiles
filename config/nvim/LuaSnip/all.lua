local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

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
}
