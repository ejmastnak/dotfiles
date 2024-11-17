local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- shebang for scripts
    s({trig = "!!", snippetType="autosnippet"},
      {t("#!/usr/bin/env python")},
      {condition = line_begin}
    ),
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
    -- Print to stderr and exit
    s({trig="fpe", snippetType="autosnippet"},
      fmt(
        [[
          print({}, file=sys.stderr)
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- MAIN FUNCTION
    s({trig="MM", snippetType="autosnippet"},
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
    -- Class
    s({trig="cll", snippetType="autosnippet"},
      fmta(
        [[
        class <>:
            <>
        ]],
        {
          i(1),
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    -- Exit with sys.exit()
    s({trig="XX", snippetType="autosnippet"},
      fmt(
        [[
        sys.exit({})
        ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- Function definition with choice node docstring
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
    -- for in
    s({trig="frr", snippetType = "autosnippet"},
      fmta(
        [[
        for <> in <>:
            <>
      ]],
        {
          i(1),
          i(2),
          i(3)
        }
      ),
      {condition = line_begin}
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
      ),
      {condition = line_begin}
    ),
    -- with open(filename) as file
    s({trig="wof", snippetType = "autosnippet"},
      fmta(
        [[
        with open(<>) as <>:
            <>
      ]],
        {
          i(1),
          i(2, 'file'),
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    -- for line in file
    s({trig="flif", snippetType = "autosnippet"},
      fmta(
        [[
        for line in file:
            <>
        ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- RETURN STATEMENT
    s({trig = ";r", snippetType = "autosnippet"},
      { t("return") },
      { condition = line_begin }
    ),
    -- KWARGS STATEMENT
    s({trig = ";k", snippetType = "autosnippet", wordTrig=false},
      { t("kwargs") }
    ),
    -- KWARGS.GET
    s({trig="kgg", snippetType = "autosnippet"},
      fmta(
        [[
        kwargs.get('<>', '<>')
        ]],
        {
          d(1, get_visual),
          i(2)
        }
      )
    ),
    -- SELF (for use in classes)
    s({trig = ";s", snippetType = "autosnippet"},
      { t("self.") }
    ),
    -- except
    s({trig="exx", snippetType = "autosnippet"},
      fmt(
        [[
        except {}:
            {}
        ]],
        {
          i(1),
          i(0),
        }
      )
    ),
    -- assert statement
    s({trig=";a", snippetType = "autosnippet"},
      {t("assert ")},
      {condition = line_begin}
    ),
    -- Square brackets
    s({trig = "gds", snippetType="autosnippet", priority=1000},
      fmta(
        [[
        [
            <>
        ]
        ]],
        { d(1, get_visual) }
      )
    ),
    -- Dictionary key-value pair
    s({trig = ">>", snippetType="autosnippet"},
      fmt(
        [[
        '{}': {},
        ]],
        { i(1), i(2) }
      ),
      {condition = line_begin}
    ),
    -- Get kwargs key-value
    s({trig = 'kwg', snippetType="autosnippet"},
      fmt(
        [[kwargs.get('{}'{})]],
        { d(1, get_visual), i(2) }
      )
    ),
    -- Try/except block
    s({trig = 'tryy', snippetType="autosnippet"},
      fmt(
        [[
        try:
          {}
        except {}:
          {}
        ]],
        {
          i(1),
          i(2, "Exception as e"),
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    -- Current time since epoch in ns
    s({trig = 'tns', snippetType="autosnippet"},
      fmt(
        [[
          timens = time.time_ns()
        ]],
        { }
      ),
      {condition = line_begin}
    ),
    -- Print time elapsed since previous time_ns call
    s({trig = 'ptns', snippetType="autosnippet"},
      fmta(
        [[ 
          print("Time: {:.<>f} <>".format((time.time_ns()-timens) / 1e<>))
        ]],
        { i(3, "3"), i(2, "ms"), i(1, "6")}
      ),
      {condition = line_begin}
    ),
    -- Format string
    s({trig = 'f"', snippetType="autosnippet", priority=1000},
      fmt(
        [[f"{}"]],
        { d(1, get_visual) }
      )
    ),
  }
