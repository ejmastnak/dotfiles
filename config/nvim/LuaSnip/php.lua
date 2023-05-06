local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- THIS
    s({trig = ";t", snippetType="autosnippet"},
      {t("$this->")}
    ),
    -- CURLY BRACES
    s({trig = "df", snippetType="autosnippet", priority=1000},
      fmta(
        [[
        {
            <>
        }
        ]],
        { d(1, get_visual) }
      )
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
    -- IF STATEMENT
    s({trig = "iff", snippetType="autosnippet"},
      fmta(
        [[
        if (<>) {
            <>
        }
        ]],
        {
          i(1),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
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
    -- Use a model
    s({trig = "uam", snippetType="autosnippet"},
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
    -- Use a controller
    s({trig = "uac", snippetType="autosnippet"},
      fmt(
        [[
        use App\Http\Controllers\{};
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Use a facade
    s({trig = "uff", snippetType="autosnippet"},
      fmt(
        [[
        use Illuminate\Support\Facades\{};
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Use Inertia
    s({trig = "uii", snippetType="autosnippet"},
      fmt(
        [[
        use Inertia\Intertia;
        ]],
        { }
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
    -- Foreign ID for Laravel migrations
    s({trig = "fkk", snippetType="autosnippet"},
      fmt(
        [[
            $table->unsignedBigInteger('{}');
            $table->foreign('{}')->references('{}')->on('{}');
        ]],
        {
          i(1),
          rep(1),
          i(2, 'id'),
          i(3)
        }
      ),
      {condition = line_begin}
    ),
    -- Return Inertia::render()
    s({trig = "rir", snippetType="autosnippet"},
      fmt(
        [[
          return Inertia::render('{}', [
            '{}' => {}
          ]);
        ]],
        {
          i(1),
          i(2),
          i(3)
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
    -- BCRYPT HASH of "password"
    s({trig = "pass", wordTrig=false},
      {t('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi')}
    ),
  }
