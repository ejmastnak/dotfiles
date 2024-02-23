-- For Laravel migrations
local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- table for creating migrations
    s({trig = "tt", snippetType="autosnippet"},
      fmt(
        [[
        $table->
        ]],
        { }
      ),
      {condition = line_begin}
    ),
    -- Foreign key for Laravel migrations
    s({trig = "tfk", snippetType="autosnippet"},
      fmt(
        [[
            $table->foreignId('{}')->references('{}')->on('{}'){};
        ]],
        {
          i(1),
          i(2, 'id'),
          i(3),
          i(4)
        }
      ),
      {condition = line_begin}
    ),
    -- Text column for Laravel migrations
    s({trig = "tss", snippetType="autosnippet"},
      fmt(
        [[
            $table->string('{}'){};
        ]],
        {
          i(1),
          i(2)
        }
      ),
      {condition = line_begin}
    ),
    -- Integer column for Laravel migrations
    s({trig = "tii", snippetType="autosnippet"},
      fmt(
        [[
            $table->integer('{}'){};
        ]],
        {
          i(1),
          i(2)
        }
      ),
      {condition = line_begin}
    ),
    -- Index for Laravel migrations
    s({trig = "txx", snippetType="autosnippet"},
      fmt(
        [[
            $table->index('{}'){};
        ]],
        {
          i(1),
          i(2)
        }
      ),
      {condition = line_begin}
    ),
    -- Boolean column for Laravel migrations
    s({trig = "tbb", snippetType="autosnippet"},
      fmt(
        [[
            $table->boolean('{}'){};
        ]],
        {
          i(1),
          i(2)
        }
      ),
      {condition = line_begin}
    ),
    -- Double column for Laravel migrations
    s({trig = "tdd", snippetType="autosnippet"},
      fmt(
        [[
            $table->double('{}', {}, {}){};
        ]],
        {
          i(1),
          i(2, "10"),
          i(3, "4"),
          i(4)
        }
      ),
      {condition = line_begin}
    ),
    -- Default column modifier for Laravel migrations
    s({trig = ";d", snippetType="autosnippet"},
      fmt(
        [[
            ->default({})
        ]],
        {
          i(1),
        }
      )
    ),
    -- Drop column
    s({trig = "tdc", snippetType="autosnippet"},
      fmt(
        [[
          $table->dropColumn('{}');
        ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- Nullable column modifier for Laravel migrations
    s({trig = ";n", snippetType="autosnippet"},
      {t("->nullable()")}
    ),
    -- cascadeOnDelete column modifier for Laravel migrations
    s({trig = ";cod", snippetType="autosnippet"},
      {t("->cascadeOnDelete()")}
    ),
  }
