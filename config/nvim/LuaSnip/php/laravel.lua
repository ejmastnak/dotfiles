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
    -- Use Hash facade
    s({trig = "ufh", snippetType="autosnippet"},
      fmt(
        [[
        use Illuminate\Support\Facades\Hash;
        ]],
        { }
      ),
      {condition = line_begin}
    ),
    -- Use Log facade
    s({trig = "ufl", snippetType="autosnippet"},
      fmt(
        [[
        use Illuminate\Support\Facades\Log;
        ]],
        { }
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
    s({trig = "dbtrr", snippetType="autosnippet"},
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
    s({trig = "dbtru", snippetType="autosnippet"},
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
    -- Log an error
    s({trig = "lge", snippetType="autosnippet"},
      fmt(
        [[
        Log::error({});
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- Log a warning
    s({trig = "lgw", snippetType="autosnippet"},
      fmt(
        [[
        Log::warning({});
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- Log a notice
    s({trig = "lgn", snippetType="autosnippet"},
      fmt(
        [[
        Log::notice({});
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- Log an info message
    s({trig = "lgi", snippetType="autosnippet"},
      fmt(
        [[
        Log::info({});
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- Log a debug message
    s({trig = "lgd", snippetType="autosnippet"},
      fmt(
        [[
        Log::debug({});
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- Abort
    s({trig = "abb", snippetType="autosnippet"},
      fmt(
        [[
        abort({});
        ]],
        {
          d(1, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- Auth::id()
    s({trig = "AID", snippetType="autosnippet"},
      {t("Auth::id()")}
    ),
    -- $this->command->info()
    s({trig = "tci", snippetType="autosnippet"},
      fmt(
        [[ $this->command->info({}); ]],
        { d(1, get_visual) }
      ),
      {condition = line_begin}
    ),
    -- $this->command->warn()
    s({trig = "tcw", snippetType="autosnippet"},
      fmt(
        [[ $this->command->warn({}); ]],
        { d(1, get_visual) }
      ),
      {condition = line_begin}
    ),
    -- $this->command->error()
    s({trig = "tce", snippetType="autosnippet"},
      fmt(
        [[ $this->command->error({}); ]],
        { d(1, get_visual) }
      ),
      {condition = line_begin}
    ),
  }
