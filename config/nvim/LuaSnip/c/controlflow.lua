local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- if statement with choice between inline and curly brackets
    s({trig = "iff", snippetType="autosnippet"},
      fmta(
        [[
          if (<>) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), d(1, get_visual), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- if not defined statement with choice between inline and curly brackets
    s({trig = "ifnn", snippetType="autosnippet"},
      fmta(
        [[
          if (!<>) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), d(1, get_visual), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- for loop
    s({trig = "frr", snippetType="autosnippet"},
      fmta(
        [[
      for (<>) <>
      ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), d(1, get_visual), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- for loop with given number of iterations
    s({trig = "flt", snippetType="autosnippet"},
      fmta(
        [[
        for (size_t i = 0; i << <>; i++) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), d(1, get_visual), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- while loop
    s({trig = "wll", snippetType="autosnippet"},
      fmta(
        [[
        while (<>) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), d(1, get_visual), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- goto cleanup
    s({trig = "gtc", snippetType="autosnippet"},
      fmta(
        [[goto cleanup;]],
        { }
      ),
      {condition = line_begin}
    ),
  }
