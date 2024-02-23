require('luasnip').filetype_extend("html", {"hugo", "tailwind"})

local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- HEADER
    s({trig="h([123456])", regTrig=true, wordTrig=false, snippetType="autosnippet"},
      fmt(
        [[
          <h{} class="{}">{}</h{}>
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
          i(2),
          d(1, get_visual),
          f( function(_, snip) return snip.captures[1] end ),
        }
      ),
      {condition = line_begin}
    ),
    -- Anchor tag (i.e. link)
    s({trig="aa", regTrig=true, wordTrig=false, snippetType="autosnippet"},
      fmt(
        [[
          <a href={} class="{}{}">{}</a>
        ]],
        {
          c(1, {sn(nil, {t('"'), i(1, ""), t('"')}), sn(nil, {t("'"), i(1, ""), t("'")})}),
          i(2),
          i(4),
          d(3, get_visual),
        }
      )
    ),
    -- GENERTIC INLINE ELEMENT
    s({trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
          {}<{} class="{}">{}</{}>
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
          i(1),
          i(2),
          d(3, get_visual),
          rep(1)
        }
      )
    ),
    -- GENERTIC TAG
    s({trig = "TT", snippetType="autosnippet"},
      fmt(
        [[
          <{}{}>
            {}
          </{}>
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
          rep(1)
        }
      )
    ),
    -- SPAN ELEMENT
    s({trig = "([^%l])spp", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
          {}<span class="{}">{}</span>
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
          i(2),
          d(1, get_visual),
        }
      )
    ),
    -- FORM TAG
    s({trig = "ff", snippetType="autosnippet"},
      fmt(
        [[
          <form{}>
            {}
          </form>
        ]],
        {
          i(1),
          d(2, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- PRE TAG
    s({trig = "prr", snippetType="autosnippet"},
      fmt(
        [[
          <pre>
            {{{{{}}}}}
          </pre>
        ]],
        {
          d(1, get_visual)
        }
      )
    ),
    -- Paragraph
    s({trig="pp", snippetType="autosnippet"},
      fmt(
        [[
          <p{}>
            {}
          </p>
        ]],
        {
          c(1, {sn(nil, {t(' class="'), i(1, ""), t('"')}), t("")}),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Inline paragraph
    s({trig="pii", snippetType="autosnippet"},
      fmt(
        [[
          <p{}>{}</p>
        ]],
        {
          i(1),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- IMG
    s({trig="imgg", snippetType="autosnippet"},
      fmt(
        [[
          <img src="{}" alt="{}" class="{}"/>
        ]],
        {
          d(1, get_visual),
          i(2),
          i(3)
        }
      )
    ),
    -- CLASS
    s({trig=";c", snippetType="autosnippet"},
      fmt(
        [[
          class="{}"
        ]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- Tailwind class set I usually apply to icons neseted in buttons
    s({trig="bcc", snippetType="autosnippet"},
      t("-ml-1 w-6 h-6 text-gray-600 shrink-0")
    ),
    -- Unordered list
    s({trig="ull", snippetType="autosnippet"},
      fmt(
        [[
          <ul{}>
            {}
          </ul>
        ]],
        {
          i(2),
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- List item
    s({trig="ii", snippetType="autosnippet"},
      fmt(
        [[
          <li{}>{}</li>
        ]],
        {
          i(2),
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- DOCUMENT TEMPLATE
    s({trig="base"},
      fmt(
        [[
        <!doctype HTML>
        <html lang="en">
          <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>{}</title>
          </head>
          <body>
            {}
          </body>
        </html>
        ]],
        {
          i(1, "FooBar"),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- Section
    s({trig = "SS", snippetType="autosnippet"},
      fmt(
        [[
          <section{}>
            {}{}
          </section>
        ]],
        {
          i(1),
          d(2, get_visual),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- DIV
    s({trig = "dd", snippetType="autosnippet"},
      fmt(
        [[
          <div class="{}">
            {}{}
          </div>
        ]],
        {
          i(2),
          d(1, get_visual),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- DIV with ID for practicing Vue
    s({trig = "dii", snippetType="autosnippet"},
      fmt(
        [[
          <div id="{}">
            {}
          </div>
        ]],
        {
          i(1),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- INPUT ELEMENT
    s({trig = "inn", snippetType="autosnippet"},
      fmt(
        [[
          <input type="{}" id="{}" />
        ]],
        {
          i(1),
          i(2)
        }
      )
    ),
    -- LABEL
    s({trig = "lbl", snippetType="autosnippet"},
      fmt(
        [[
          <label for="{}">
            {}
          </label>
        ]],
        {
          i(1),
          d(2, get_visual)
        }
      )
    ),
    -- BUTTON
    s({trig = "bb", snippetType="autosnippet"},
      fmt(
        [[
          <button type="{}"{}>
            {}
          </button>
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- STRONG ELEMENT
    s({trig = "tbb", snippetType="autosnippet"},
      fmt(
        [[
          <strong class="{}">{}</strong>
        ]],
        {
          i(2, "font-medium"),
          d(1, get_visual),
        }
      )
    ),
  }
