local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

-- Environment/syntax context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end
tex.in_tikz = function()
  local is_inside = vim.fn['vimtex#env#is_inside']("tikzpicture")
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

-- Return snippet tables
return
{
  s({trig="LL", snippetType="autosnippet"},
    {
      t("& "),
    }
  ),
  s({trig="qq", snippetType="autosnippet"},
    {
      t("\\qquad"),
    }
  ),
  s({trig="and", snippetType="autosnippet"},
    {
      t("\\quad \\text{and} \\quad"),
    },
    {condition = tex.in_mathzone}
  ),
  s({trig = "^[%s]*toc", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    {
      f( function(_, snip) return snip.captures[1] end ),
      t("\\tableofcontents"),
  }),
  s({trig="^([%s]*)ii", regTrig = true, snippetType="autosnippet"},
    {
      f( function(_, snip) return snip.captures[1] end ),
      t("\\item "),
  }),
s({trig = "^([%s]*)h1", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      [[<>\section{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  s({trig = "^([%s]*)h2", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      [[<>\subsection{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  s({trig = "^([%s]*)h3", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      [[<>\subsubsection{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
}
