local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- main() function with void argument
    s({trig = "imv", snippetType="autosnippet"},
      fmta(
        [[
      int main(void) {
          <>
      }
      ]],
        { i(0) }
      ),
      {condition = line_begin}
    ),
    -- main() function with argc/argv
    s({trig = "ima", snippetType="autosnippet"},
      fmta(
        [[
      int main(int argc, char* argv[argc]) {
          <>
      }
      ]],
        { i(0) }
      ),
      {condition = line_begin}
    ),
    -- Function
    s({trig = "ff", snippetType="autosnippet"},
      fmta(
        [[
          <> <>(<>) <>
        ]],
        { 
          i(1),
          i(2),
          i(3),
          c(4, {sn(nil, {t("{"), t({"", "    "}), d(1, get_visual), t({"", "}"})}), t("")}),
        }
      ),
      {condition = line_begin}
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
    -- size_t i = 0 (for loops)
    s({trig = "sti", snippetType="autosnippet"},
      fmt(
        [[
        size_t i = {};
        ]],
        { i(1, "0") }
      )
    ),
    -- BLOCK COMMENT
    s({trig = "cc", snippetType="autosnippet"},
      fmta(
        [[
      /**
        <>
       */
      ]],
        { i(1) }
      ),
      {condition = line_begin}
    ),
    -- Define a struct
    s({trig = "tds", snippetType="autosnippet"},
      fmta(
        [[
        typedef struct <> <>;
        struct <> {
            <>
        };
      ]],
        { 
          i(1),
          rep(1),
          rep(1),
          i(2),
        }
      )
    ),
    -- Define an enum
    s({trig = "tde", snippetType="autosnippet"},
      fmta(
        [[
        typedef enum <> <>;
        enum <> {
            <>
        };
      ]],
        { 
          i(1),
          rep(1),
          rep(1),
          i(2),
        }
      )
    ),
    -- -> DEREFERENCE STRUCTURE PROPERTY
    s({trig = ">>", snippetType="autosnippet", wordTrig=false},
      {
        t("->")
      }
    ),
    -- RETURN
    s({trig = "rr", snippetType="autosnippet", wordTrig=false},
      {
        t("return")
      },
      { condition = line_begin }
    ),
    -- #define
    s({trig = "dff", snippetType="autosnippet"},
      fmta(
        [[
          #define <> (<>)
        ]],
        { i(1), i(2) }
      ),
      {condition = line_begin}
    ),
    -- #ifndef
    s({trig = "ifnd", snippetType="autosnippet"},
      fmt(
        [[
          #ifndef {}
          #define {} ({})
          #endif
        ]],
        {
          i(1),
          rep(1),
          i(2),
        }
      ),
      {condition = line_begin}
    ),
    -- return
    s({trig = ";r", snippetType="autosnippet"},
      fmt(
        [[
          return {};
        ]],
        {
          i(1),
        }
      )
    ),
    -- LONG STRING OF DASHES FOR COMMENTS
    s({trig = "--", snippetType="autosnippet"},
      {t('// ------------------------------------------------------------------ //')},
      {condition = line_begin}
    ),
    -- puts with quotes
    s({trig = "pts", snippetType="autosnippet"},
      fmta(
        [[puts("<>");]],
        { 
          i(1),
        }
      ),
      { condition = line_begin }
    ),
    -- fputs to standard error
    s({trig = "fpts", snippetType="autosnippet"},
      fmta(
        [[fputs("<>\n", <>);]],
        { 
          d(1, get_visual),
          i(2, "stderr"),
        }
      ),
      { condition = line_begin }
    ),
    -- printf with quotes and a new line
    s({trig = "pp", snippetType="autosnippet"},
      fmta(
        [[printf("<>\n"<>);]],
        { 
          i(1),
          i(2)
        }
      )
    ),
    -- printf to standard error
    s({trig = "fpf", snippetType="autosnippet"},
      fmta(
        [[fprintf(<>, <>);]],
        { 
          i(1, "stderr"),
          d(2, get_visual),
        }
      )
    ),
    -- getline() boilerplate
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
    -- exit()
    s({trig = "XX", snippetType="autosnippet"},
      fmta(
        [[
        exit(<>);
        ]],
        { 
          i(1, "EXIT_FAILURE"),
        }
      ),
      { condition = line_begin }
    ),
    -- exitcode
    s({trig = "xxc", snippetType="autosnippet"},
      {t('exitcode')}
    ),
    -- EXIT_SUCCESS
    s({trig = "xxs", snippetType="autosnippet"},
      {t('EXIT_SUCCESS')}
    ),
    -- EXIT_FAILURE
    s({trig = "xxf", snippetType="autosnippet"},
      {t('EXIT_FAILURE')}
    ),
    -- null pointer
    s({trig = "v0", snippetType="autosnippet"},
      {t('(void*)0')}
    ),
  }
