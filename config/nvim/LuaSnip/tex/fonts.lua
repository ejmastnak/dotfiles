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
{
  -- TYPEWRITER i.e. \texttt
  s({trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\texttt{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  -- ITALIC i.e. \textit
  s({trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\textit{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  -- BOLD i.e. \textbf
  s({trig = "([^%a])tbb", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\textbf{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  -- MATH ROMAN i.e. \mathrm
  s({trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\mathrm{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  -- MATH CALIGRAPHY i.e. \mathcal
  s({trig = "([^%a])mcc", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\mathcal{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  -- MATH BOLDFACE i.e. \mathbf
  s({trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\mathbf{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  -- MATH BLACKBOARD i.e. \mathbb
  s({trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>\\mathbb{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
}
