local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
  {
    -- HUGO RELREF MARKDOWN LINK
    s({trig="rll", snippetType="autosnippet"},
      fmt(
        [[
          {{{{< relref "{}" >}}}}
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- SHORTCODE
    s({trig="scc", snippetType="autosnippet"},
      fmt(
        [[
          {{< () >}}
        ]],
        {
          d(1, get_visual),
        },
        { delimiters = '()'}
      )
    ),
    -- TOC SHORTCODE
    s({trig="toc"},
      fmt(
        [[

          {{< toc level="()" title="()" >}}
        ]],
        {
          i(1, "2"),
          i(2, "Contents of this article"),
        },
        { delimiters = '()'}
      )
    ),
    -- DATE LAST MODIFIED SHORTCODE
    s({trig="date"},
      fmt(
        [[
          {{< date-last-mod >}}
        ]],
        {
        },
        { delimiters = '()'}
      )
    ),
    -- DETAILS/SUMMARY SHORTCODE
    s({trig="dtt", snippetType="autosnippet"},
      fmt(
        [[
          {{< details summary="()" >}}
          ()
          {{< /details >}}
        ]],
        {
          i(1),
          d(2, get_visual),
        },
        { delimiters = '()'}
      )
    ),
    -- SHORTCODE for centered image
    s({trig="imc", snippetType="autosnippet"},
      fmt(
        [[
          {{< img-centered src="()" width="()" >}}
        ]],
        {
          d(1, get_visual),
          i(2, "100%"),
        },
        { delimiters = '()'}
      )
    ),
  }
