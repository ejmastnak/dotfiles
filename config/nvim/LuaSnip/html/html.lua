local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- HEADER
    s({trig="h([123456])", regTrig=true, wordTrig=false, snippetType="autosnippet"},
      fmt(
        [[
          <h{}>{}</h{}>
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
          f( function(_, snip) return snip.captures[1] end ),
        }
      ),
      {condition = line_begin}
    ),
    -- PARAGRAPH
    s({trig="pp", snippetType="autosnippet"},
      fmt(
        [[
          <p>{}</p>
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- UNORDERED LIST
    s({trig="itt", snippetType="autosnippet"},
      fmt(
        [[
          <ul>
            <li>{}</li>{}
          </ul>
        ]],
        {
          i(1),
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- LIST ITEM
    s({trig="ii", snippetType="autosnippet"},
      fmt(
        [[
            <li>{}</li>
        ]],
        {
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
          <meta charset="UTF-8">
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
    -- ANCHOR TAG
    s({trig = "([^%l])aa", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        [[
          {}<a href="{}">{}</a>
        ]],
        {
          f( function(_, snip) return snip.captures[1] end ),
          i(1),
          d(2, get_visual),
        }
      )
    ),
  }




