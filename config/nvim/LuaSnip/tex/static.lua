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
-- MANUALLY TRIGGERED SNIPPETS
{},
-- AUTOTRIGGERED SNIPPETS
{
  s({trig="LL"},
    {
      t("& "),
    }
  ),
  s({trig="qq"},
    {
      t("\\qquad"),
    }
  ),
  s({trig="and"},
    {
      t("\\quad \\text{and} \\quad"),
    },
    {condition = tex.in_mathzone}
  ),
  s({trig = "^[%s]*toc", regTrig = true, wordTrig = false},
    {
      f( function(_, snip) return snip.captures[1] end ),
      t("\\tableofcontents"),
  }),
  s({trig="^([%s]*)%-%-", regTrig = true},
    {
      f( function(_, snip) return snip.captures[1] end ),
      t("\\item "),
  }),
s({trig = "^([%s]*)h1", regTrig = true, wordTrig = false},
    fmta(
      [[<>\section{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  s({trig = "^([%s]*)h2", regTrig = true, wordTrig = false},
    fmta(
      [[<>\subsection{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  s({trig = "^([%s]*)h3", regTrig = true, wordTrig = false},
    fmta(
      [[<>\subsubsection{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
}
