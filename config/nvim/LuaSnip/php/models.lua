-- For Laravel Eloquent models
local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- fillable property
    s({trig = "prf", snippetType="autosnippet"},
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
    -- belongsTo relationship
    s({trig = "rbt", snippetType="autosnippet"},
      fmta(
        [[
        public function <>() {
            return $this->>belongsTo(<>::class, '<>', '<>');
        }
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(4, "id"),
        }
      ),
      {condition = line_begin}
    ),
    -- hasOne relationship
    s({trig = "rho", snippetType="autosnippet"},
      fmta(
        [[
        public function <>() {
            return $this->>hasOne(<>::class, '<>', '<>');
        }
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(4, "id"),
        }
      ),
      {condition = line_begin}
    ),
    -- hasMany relationship
    s({trig = "rhm", snippetType="autosnippet"},
      fmta(
        [[
        public function <>() {
            return $this->>hasMany(<>::class, '<>', '<>');
        }
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(4, "id"),
        }
      ),
      {condition = line_begin}
    ),
    -- Create a new model
    s({trig = ":CC", snippetType="autosnippet"},
      fmt(
        [[
        {}::create([
            '{}' => {},
        ]);
        ]],
        {
          i(1),
          i(2),
          i(3),
        }
      ),
      {condition = line_begin}
    ),
    -- Update an existing model
    s({trig = ":UU", snippetType="autosnippet"},
      fmt(
        [[
        {}::update([
            '{}' => {},
        ]);
        ]],
        {
          i(1),
          i(2),
          i(3),
        }
      ),
      {condition = line_begin}
    ),
  }
