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
    -- Fenced block of code
    s({trig="cc", snippetType="autosnippet"},
      fmta(
        [[
        ```<>
        <>
        ```
      ]],
        {
          i(1),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- TODO NOTE
    s({trig="TODOO", snippetType="autosnippet"},
      {
        t("**TODO:** "),
      }
    ),
    -- LINK
    s({trig="LL", wordTrig=true, snippetType="autosnippet"},
      fmta(
        [[[<>](<>)]],
        {
          d(1, get_visual),
          i(2),
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
    -- SUMMARY/DETAILS HTML for Jekyll
    s({trig="det"},
      fmt(
        [[
        <details>
        <summary>
        {}
        </summary>
        {}
        </details>
        ]],
        {
          i(1),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- MARKDOWNIFY filter for Jekyll
    s({trig="md"},
      fmta(
        [[
        {{
          "
          <>
          "
        | markdownify }}
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- BASH CODE BLOCK
    s({trig="bash"},
      fmta(
        [[
        ```bash
        <>
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- PHP CODE BLOCK
    s({trig="php", snippetType="autosnippet"},
      fmt(
        [[
        ```php
        <?php
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- PYTHON CODE BLOCK
    s({trig="py", snippetType="autosnippet"},
      fmt(
        [[
        ```python
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- BASH CODE BLOCK
    s({trig="sh", snippetType="autosnippet"},
      fmt(
        [[
        ```bash
        {}
        ```
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
  }

