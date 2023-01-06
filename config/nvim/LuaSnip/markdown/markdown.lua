local function get_visual(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- TODO NOTE
    s({trig="TODOO", snippetType="autosnippet"},
      {
        t("**TODO:** "),
      }
    ),
    -- LINK; CAPTURE TEXT IN VISUAL
    s({trig="LL", wordTrig=true, snippetType="autosnippet"},
      fmta(
        [[[<>](<>)]],
        {
          d(1, get_visual),
          i(2),
        }
      )
    ),
    -- LINK; CAPTURE URL IN VISUAL
    s({trig="LU", wordTrig=true, snippetType="autosnippet"},
      fmta(
        [[[<>](<>)]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    -- BOLDFACE TEXT
    s({trig="tbb", snippetType="autosnippet"},
      fmta(
        [[**<>**]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- ITALIC TEXT
    s({trig="tii", snippetType="autosnippet"},
      fmta(
        [[*<>*]],
        {
          d(1, get_visual),
        }
      )
    ),
  }

