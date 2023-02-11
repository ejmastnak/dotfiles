local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- THIS
    s({trig = ";t", snippetType="autosnippet"},
      {t("$this->")}
    ),
    -- RETURN
    s({trig = "rr", snippetType="autosnippet"},
      {t("return ")},
      {condition = line_begin}
    ),
    -- REQUEST
    s({trig = ";r", snippetType="autosnippet"},
      {t("$request")}
    ),
    -- PUBLIC FUNCTION
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
          i(0)
        }
      ),
      {condition = line_begin}
    ),
    -- PRINT
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
    -- USE FAKER IN FACTORY
    s({trig = "fake", snippetType="autosnippet"},
      fmt(
        [[
        '{}' => fake()->{}({});
        ]],
        {
          d(1, get_visual),
          i(2),
          i(3)
        }
      ),
      {condition = line_begin}
    ),
    -- FILLABLE PROPERTY
    s({trig = "fill", snippetType="autosnippet"},
      fmt(
        [[
        protected $fillable = [
            {}
        ];
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- IMPORT A MODEL
    s({trig = "AM", snippetType="autosnippet"},
      fmt(
        [[
        use App\Models\{};
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- TABLE (for creating migrations)
    s({trig = "tt", snippetType="autosnippet"},
      fmt(
        [[
        $table->
        ]],
        { }
      ),
      {condition = line_begin}
    ),
  }
