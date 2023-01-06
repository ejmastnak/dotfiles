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
    -- TABLE
    s({trig="tbl", snippetType="autosnippet"},
      fmt(
        [[
          <table>
            {}
          </table>
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- TABLE HEADER
    s({trig="tbh", snippetType="autosnippet"},
      fmt(
        [[
          <thead>
            {}
          </thead>
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- TABLE BODY
    s({trig="tbb", snippetType="autosnippet"},
      fmt(
        [[
          <tbody>
            {}
          </tbody>
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- TABLE DATA
    s({trig="tdd", snippetType="autosnippet"},
      fmt(
        [[
          <td>{}</td>
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- TABLE HEADER
    s({trig="thh", snippetType="autosnippet"},
      fmt(
        [[
          <th>{}</th>
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
  }
