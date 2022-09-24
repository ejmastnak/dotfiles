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
  s({trig = "ann"},
    fmta(
      [[
      \annotate{<>}{<>}
      ]],
      {
        i(1),
        d(2, get_visual),
      }
    )
  ),
}
