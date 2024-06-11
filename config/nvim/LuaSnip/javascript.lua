local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- ALERT
    s({trig = "aa", snippetType="autosnippet", priority=10000},
      fmta(
        [[
        alert(<>);
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- ALERT
    s({trig = "frr", snippetType="autosnippet", priority=10000},
      fmta(
        [[
        for (<>) {
          <>
        }
        ]],
        {
          i(1),
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    -- LOG TO CONSOLE
    s({trig = "cll", snippetType="autosnippet"},
      fmta(
        [[
        console.log(<>);
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Set session storage key, value pair
    s({trig = "sss", snippetType="autosnippet"},
      fmt(
        [[
        sessionStorage.setItem('{}', {})
        ]],
        {
          i(1),
          i(2),
        }
      ),
      {condition = line_begin}
    ),
    -- Get session storage value
    s({trig = "ssg", snippetType="autosnippet"},
      fmt(
        [[

        sessionStorage.getItem('{}');
        ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- if statement with choice between inline and curly brackets
    s({trig = "iff", snippetType="autosnippet"},
      fmta(
        [[
          if (<>) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "  "}), d(1, get_visual), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- Set timeout
    s({trig = "stt", snippetType="autosnippet"},
      fmta(
        [[
        setTimeout(() =>> {
          <><>
        }, <>);
        ]],
        {
          i(1),
          i(3),
          i(2, "3000")
        }
      ),
      {condition = line_begin}
    ),
    -- Comment line
    s({trig = "--", snippetType="autosnippet"}, {
      t("// ------------------------------------------------------------------------- //")
    },
      {condition = line_begin}
    ),

    -- new "key-value pair" in Javascript object
    s({trig = ">>", snippetType="autosnippet"},
      fmt(
        [[
          {}: {},
        ]],
        {
          i(1),
          i(2),
        }
      ),
      {condition = line_begin}
    ),
  }

