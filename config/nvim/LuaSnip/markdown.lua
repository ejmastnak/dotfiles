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
  s({trig="^cc", regTrig = true},
    fmta(
      [[
        ```<>
        <>
        ```
        <>
      ]],
      {
        i(1, ""),
        d(2, get_visual),
        i(0, ""),
      }
    )),
}
