local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

-- Return snippet tables
return
-- Manually triggered snippets
{},
-- Autotriggered snippets
{
  -- Fenced block of code
  s({trig="^([%s]*)cc", regTrig = true},
    fmta(
      [[
        <>```<>
        <><>
        <>```
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1, ""),
        f( function(_, snip) return snip.captures[1] end ),
        d(2, get_visual),
        f( function(_, snip) return snip.captures[1] end ),
      }
    )
  ),
  -- TODO NOTE
  s({trig="TODOO"},
      {
        t("*TODO:* "),
      }
    ),
  -- LINK
  s({trig="LL", wordTrig=true},
    fmta(
      [[[<>](<>)]],
      {
        d(1, get_visual),
        i(2),
      }
    )
  ),
  -- BOLDFACE TEXT
  s({trig="tbb"},
    fmta(
      [[**<>**]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- ITALIC TEXT
  s({trig="tii"},
    fmta(
      [[*<>*]],
      {
        d(1, get_visual),
      }
    )
  ),
}
