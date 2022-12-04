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
    -- MAIN FUNCTION
    s({trig = "main", snippetType="autosnippet"},
      fmta(
        [[
      int main()
      {
          <>
          return 0;
      }
      ]],
        { i(1) }
      ),
      {condition = line_begin}
    ),
    -- GENRIC FUNCTION
    s({trig = "ff", snippetType="autosnippet"},
      fmta(
        [[
          /*
            <>
          */
          <>(<>)
          {
              <>
          }
        ]],
        { 
          i(3),
          i(1),
          i(2),
          d(4, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- VOID FUNCTION
    s({trig = "vv", snippetType="autosnippet"},
      fmta(
        [[
          /*
            <>
          */
          void <>(<>)
          {
              <>
          }
        ]],
        { 
          i(3),
          i(1),
          i(2),
          d(4, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- BLOCK COMMENT
    s({trig = "cc", snippetType="autosnippet"},
      fmta(
        [[
      /*
        <>
      */
      ]],
        { i(1) }
      ),
      {condition = line_begin}
    ),
    -- CURLY BRACES
    s({trig = "df", snippetType="autosnippet"},
      fmta(
        [[
      {
          <>
      }
      ]],
        { i(0) }
      )
    ),
    -- DATA STRUCTURE
    s({trig = "ss", snippetType="autosnippet"},
      fmta(
        [[
        struct <> {
            <>
        };
      ]],
        { 
          i(1),
          i(0)
        }
      )
    ),
    -- -> DEREFERENCE STRUCTURE PROPERTY
    s({trig = ">>", snippetType="autosnippet", wordTrig=false},
      {
        t("->")
      }
    ),
    -- NULL POINTER SYMBOLIC CONSTANT
    s({trig = "00", snippetType="autosnippet", wordTrig=false},
      {
        t("NULL")
      }
    ),
    -- RETURN
    s({trig = "rr", snippetType="autosnippet", wordTrig=false},
      {
        t("return")
      },
      { condition = line_begin }
    ),
  }
