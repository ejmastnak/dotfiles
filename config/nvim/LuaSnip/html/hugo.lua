-- Snippets for use with Hugo

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
    -- BLOCK FOR BASE TEMPLATES
    s({trig="bblock"},
      fmt(
        [[
          {{ block "[]" [] }}
            []
          {{ end }}
        ]],
        {
          i(1),
          i(2, '.'),
          d(3, get_visual),
        },
        { delimiters = "[]" }
      ),
      {condition = line_begin}
    ),
    -- DEFINE BLOCK FOR OVERRIDING BASE BLOCK
    s({trig="dblock"},
      fmt(
        [[
          {{ define "[]" }}
            []
          {{ end }}
        ]],
        {
          i(1),
          d(2, get_visual),
        },
        { delimiters = "[]" }
      ),
      {condition = line_begin}
    ),
    -- .Content variable
    s({trig="cc", snippetType="autosnippet"},
      { t("{{ .Content }}") },
      {condition = line_begin}
    ),
  }




