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
    -- CLASS
    s({trig="cll", snippetType="autosnippet"},
      fmta(
        [[
        class <>:
        ]],
        {
          i(1),
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
    -- for _ in range()
    s({trig="fir", snippetType = "autosnippet"},
      fmta(
        [[
        for <> in range(<>):
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
    -- Open a filew
    s({trig="wfo", snippetType = "autosnippet"},
      fmta(
        [[
        with open(<>, '<>', encoding="<>") as <>:
          <>
        ]],
        {
          i(1),
          i(2),
          i(3, "utf-8"),
          i(4, "f"),
          i(0),
        }
      )
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
    -- Path.as_posix()
    s({trig="PAP", snippetType = "autosnippet"},
      {t("path.as_posix()")}
    ),
    -- as_posix()
    s({trig="APP", snippetType = "autosnippet", wordTrig=false},
      {t("as_posix()")}
    ),
    -- Path.name
    s({trig="PNN", snippetType = "autosnippet"},
      {t("path.name")}
    ),
  }
