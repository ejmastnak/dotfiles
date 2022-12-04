local function get_visual(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

local function get_lilypond_version()
  -- The call to `tr` removes trailing newline character
  local handle = io.popen("lilypond --version | head -1 | sed 's/GNU LilyPond //' | tr -d '\n'")
  local result = handle:read("*a")
  handle:close()
  return result
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- HEADER
    s({trig="hh", snippetType="autosnippet"},
      fmta(
        [[
        \header{
          <>
        }
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- RELATIVE BLOCK
    s({trig="rr", snippetType="autosnippet"},
      fmta(
        [[
        \relative{
          <>
        }
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- SCORE BLOCK
    s({trig="ss", snippetType="autosnippet"},
      fmta(
        [[
        \score{
          <>
        }
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- TITLE FIELD
    s({trig="tt", snippetType="autosnippet"},
      fmta(
        [[
        title = "<>"
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- LILYPOND VERSION
    s({trig = "vv", snippetType="autosnippet"},
      fmta(
        [[
          \version "<>"
        ]],
        { 
          f(get_lilypond_version)
        }
      )
    ),
    -- CURLY BRACES
    s({trig = "df", snippetType="autosnippet"},
      fmta(
        [[
        {
          <>
        }
        ]],
        { i(0) }
      )
    ),
  }

