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
    s({trig="cc", snippetType = "autosnippet"},
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
    -- HTML CODE BLOCK
    s({trig="html"},
      fmta(
        [[
        ```html
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
    s({trig="php"},
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
    s({trig="py"},
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
    -- BEANCOUNT CODE BLOCK
    s({trig="bc"},
      fmt(
        [[
        ```beancount
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
    s({trig="sh"},
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
    -- SQL CODE BLOCK
    s({trig="sql"},
      fmt(
        [[
        ```sql
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

