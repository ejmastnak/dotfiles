local function get_visual(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
{
  -- PRINTF
  s({trig = "pp", snippetType="autosnippet"},
    fmta(
      [[printf("<>"<>);]],
      { 
        i(1),
        i(2)
      }
    ),
    { condition = line_begin }
  ),
  -- GETLINE BOILERPLATE
  s({trig = "gll", snippetType="autosnippet"},
    fmta(
      [[
      char *line = NULL;
      size_t len = 0;
      ssize_t nread;
      nread = getline(&line, &len, stdin);
      <>
      free(line);
      ]],
      { i(0) }
    )
  ),
}
