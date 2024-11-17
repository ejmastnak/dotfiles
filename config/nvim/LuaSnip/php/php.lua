local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- $this keyword
    s({trig = ";t", snippetType="autosnippet"},
      {t("$this->")}
    ),
    -- $self keyword
    s({trig = ";s", snippetType="autosnippet"},
      {t("$self::")}
    ),
    -- A variable
    s({trig = "vv", snippetType="autosnippet"},
      {t("$")}
    ),
    -- Curly braces
    s({trig = "fds", snippetType="autosnippet", priority=1000},
      fmta(
        [[
        {
            <>
        }
        ]],
        { d(1, get_visual) }
      )
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
    -- try/catch
    s({trig = "trr", snippetType="autosnippet"},
      fmta(
        [[
        try {
          <>
        } catch (<> $e) {
          <>
        }
        ]],
        {
          d(1, get_visual),
          i(2, "\\Exception"),
          i(3),
        }
      )
    ),
    -- REQUEST
    s({trig = ";r", snippetType="autosnippet"},
      {t("$request")}
    ),
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
    -- if is_null with choice between inline and curly brackets
    s({trig = "ifnn", snippetType="autosnippet"},
      fmta(
        [[
          if (is_null(<>)) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), i(1, ""), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- if !is_null with choice between inline and curly brackets
    s({trig = "ifNN", snippetType="autosnippet"},
      fmta(
        [[
          if (!is_null(<>)) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), i(1, ""), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- if property exists with choice between inline and curly brackets
    s({trig = "ifee", snippetType="autosnippet"},
      fmta(
        [[
          if (property_exists(<>)) <>
        ]],
        { 
          i(1),
          c(2, {sn(nil, {t("{"), t({"", "    "}), i(1, ""), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
    ),
    -- public function
    s({trig = "ff", snippetType="autosnippet"},
      fmta(
        [[
        public function <>(<>) {
            <>
        }
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- public static function
    s({trig = "psf", snippetType="autosnippet"},
      fmta(
        [[
        public static function <>(<>) {
            <>
        }
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Private function
    s({trig = "pvf", snippetType="autosnippet"},
      fmta(
        [[
        private function <>(<>) {
            <>
        }
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Public function
    s({trig = "pff", snippetType="autosnippet"},
      fmta(
        [[
        public function <>(<>) {
            <>
        }
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Foreach loop
    s({trig = "frr", snippetType="autosnippet"},
      fmta(
        [[
          foreach (<> as <>) {
              <>
          }
        ]],
        {
          i(1),
          i(2),
          i(3)
        }
      ),
      {condition = line_begin}
    ),
    -- For loop
    s({trig = "forr", snippetType="autosnippet"},
      fmta(
        [[
          for (<>) {
              <>
          }
        ]],
        {
          i(1),
          i(2),
        }
      ),
      {condition = line_begin}
    ),
    -- Print
    s({trig = "pp", snippetType="autosnippet"},
      fmta(
        [[
        print(<>);
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Var Dump
    s({trig = "vdd", snippetType="autosnippet"},
      fmta(
        [[
        var_dump(<>);
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- DIE DUMP
    s({trig = "dd", snippetType="autosnippet"},
      fmta(
        [[
        dd(<>);
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- BLOCK COMMENT
    s({trig = "cc", snippetType="autosnippet"},
      fmta(
        [[
        /**
         *  <>
         */
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- MAP OVER ARRAY (used to modify Laravel collections)
    s({trig = "mpp", snippetType="autosnippet"},
      fmt(
        [[
        ->map(function (${}) => [
          {}
        ])
        ]],
        { 
          i(1),
          i(2)
        }
      )
    ),
    -- MAP ITEM (the pattern usually used in map calls)
    s({trig = "mii", snippetType="autosnippet"},
      fmt(
        [[
        '{}' => ${}->{}
        ]],
        { 
          i(1),
          i(2),
          rep(1)
        }
      ),
      { condition=line_begin }
    ),
    -- New associative array key/value pair
    s({trig = ">>", snippetType="autosnippet"},
      fmt(
        [[
        '{}' => {},
        ]],
        {
          i(1),
          i(2),
        }
      ),
      { condition=line_begin }
    ),
    -- -> pointer dereferencing operator
    s({trig = '([%w])>>', regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmt(
        "{}{}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          t("->")
        }
      )
    ),
  }
