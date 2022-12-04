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
    -- PRINT STATEMENT
    s({trig="pp", snippetType="autosnippet"},
      fmta(
        [[print(<>)]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- MAIN FUNCTION
    s({trig="main", snippetType="autosnippet"},
      fmta(
        [[
      if __name__ == "__main__":
          <>
      ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- EXIT MAIN FUNCTION with sys.exit()
    s({trig="XX", snippetType="autosnippet"},
      { t("sys.exit()") },
      {condition = line_begin}
    ),
    -- FUNCTION DEFINITION WITH CHOICE NODE DOCSTRING
    -- The idea is to let you choose if you want to use the docstring or not
    s({trig="ff", snippetType="autosnippet"},
      fmta(
        [[
      def <>(<>):
          <><>
      ]],
        {
          i(1),
          i(2),
          c(3, {sn(nil, {t({"\"\"\"", ""}), t("    "), i(1, ""), t({"", "    \"\"\"", "    "})}), t("")}),
          -- t("    "),
          d(4, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- __INIT__ METHOD/CONSTRUCTOR
    s({trig="__", snippetType="autosnippet"},
      fmta(
        [[
        def __init__(self<>):
            <>
      ]],
        {
          i(1),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- TIME, i.e. snippet for timing code execution
    s({trig="time"},
      fmta(
        [[
        start = time.time()
        <>
        end = time.time()
      ]],
        {
          d(1, get_visual),
        }
      )
    ),
    -- IF STATEMENT
    s({trig="iff", snippetType = "autosnippet"},
      fmta(
        [[
        if <>:
            <>
      ]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    -- RETURN STATEMENT
    s({trig = ";r", snippetType = "autosnippet"},
      { t("return") },
      { condition = line_begin }
    ),
    -- SELF (for use in classes)
    s({trig = ";s", snippetType = "autosnippet"},
      { t("self") }
    ),
  }
