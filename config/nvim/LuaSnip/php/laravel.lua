local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Use faker (for use in model factories)
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
    -- Use a service
    s({trig = "uas", snippetType="autosnippet"},
      fmt(
        [[
        use App\Services\{};
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Use a job
    s({trig = "uaj", snippetType="autosnippet"},
      fmt(
        [[
        use App\Jobs\{};
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
    -- Use a request
    s({trig = "uar", snippetType="autosnippet"},
      fmt(
        [[
        use App\Http\Requests\{};
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Use a rule
    s({trig = "uaR", snippetType="autosnippet"},
      fmt(
        [[
        use App\Rules\{};
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
    -- Use DB facade
    s({trig = "ufd", snippetType="autosnippet"},
      fmt(
        [[
        use Illuminate\Support\Facades\DB;
        ]],
        { }
      ),
      {condition = line_begin}
    ),
    -- Use Storage facade
    s({trig = "ufs", snippetType="autosnippet"},
      fmt(
        [[
        use Illuminate\Support\Facades\Storage;
        ]],
        { }
      ),
      {condition = line_begin}
    ),
    -- Use Inertia
    s({trig = "uii", snippetType="autosnippet"},
      fmt(
        [[
        use Inertia\Inertia;
        ]],
        { }
      ),
      {condition = line_begin}
    ),
    -- Return Inertia::render()
    s({trig = "rir", snippetType="autosnippet"},
      fmt(
        [[
          return Inertia::render('{}', [
              '{}' => {},
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
    -- BCRYPT HASH of "password"
    s({trig = "pass", wordTrig=false},
      {t('$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi')}
    ),
    -- Shortcut for creating models from incoming requests in controllers
    s({trig = ">R", snippetType="autosnippet"},
      fmt(
        [[
        '{}' => $request->{},
        ]],
        {
          i(1),
          i(2),
        }
      ),
      {condition = line_begin}
    ),
    -- "return Redirect::route();" to e.g. exit controller methods
    s({trig = "rrr", snippetType="autosnippet"},
      fmt(
        [[
        Redirect::route({}){};
        ]],
        {
          i(1),
          i(2),
        }
      ),
      {condition = line_begin}
    ),
    -- $validated, for accessing validated form data
    s({trig = ";v", snippetType="autosnippet"},
      fmt(
        [[
        $validated['{}']
        ]],
        {
          i(1),
        }
      )
    ),
    -- Assign a model property to a $validated request key
    s({trig = ">V", snippetType="autosnippet"},
      fmt(
        [[
        '{}' => $validated['{}'],
        ]],
        {
          i(1),
          rep(1),
        }
      )
    ),
    -- Database transaction
    s({trig = "trr", snippetType="autosnippet"},
      fmta(
        [[
        DB::transaction(function () {
            <>
        });
        ]],
        {
          d(1, get_visual)
        }
      )
    ),
    -- Database transaction with use of outside scope
    s({trig = "tru", snippetType="autosnippet"},
      fmta(
        [[
        DB::transaction(function () use (<>) {
            <>
        });
        ]],
        {
          i(1),
          d(2, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- Conditional based on app environment
    s({trig = "ifae", snippetType="autosnippet"},
      fmta(
        [[
        if (\App::environment('<>')) {
            <>
        }
        ]],
        {
          i(1),
          d(2, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- Log info to console for Artisan commands, e.g. when seeding DB
    s({trig = "cii", snippetType="autosnippet"},
      fmt(
        [[
        $this->command->info({});
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
  }
