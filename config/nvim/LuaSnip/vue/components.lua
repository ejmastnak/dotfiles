require('luasnip').filetype_extend("vue", {"html", "javascript"})

local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Inertia Link using Ziggy route binding
    s({trig = "mll", snippetType="autosnippet"},
      fmt(
        [[
          <MyLink :href="route({})">
            {}
          </MyLink>
        ]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    -- Inertia Link used with a regular non-SPA https link
    s({trig = "mlp", snippetType="autosnippet"},
      fmt(
        [[
          <MyLink :colored="true" href="{}">{}</MyLink>
        ]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    -- TextArea/InputLabel/InputError combo
    s({trig = "tarr", snippetType="autosnippet"},
      fmt(
        [[
          <div class="mt-2 w-full max-w-[22rem]">
            <InputLabel for="{}" value="{}" />
            <TextArea
              id="{}"
              class="block w-full text-sm h-64"
              v-model="{}"
              required
            />
            <InputError class="mt-2" :message="form.errors.{}" />
          </div>
        ]],
        {
          i(1),
          i(2),
          rep(1),
          i(3),
          rep(1),
        }
      ),
      {condition = line_begin}
    ),
    -- TextInput/InputLabel/InputError combo
    s({trig = "tinn", snippetType="autosnippet"},
      fmt(
        [[
          <div class="mt-2 w-full max-w-xl">
            <InputLabel for="{}" value="{}" />
            <TextInput
              id="{}"
              type="{}"
              class="inline-block w-{}"
              v-model="{}"
              required
            />
            <InputError class="mt-2" :message="form.errors.{}" />
          </div>
        ]],
        {
          i(1),
          i(2),
          rep(1),
          i(3, "text"),
          i(4, "72"),
          i(5),
          rep(1),
        }
      ),
      {condition = line_begin}
    ),
    -- InputError combo
    s({trig = "inee", snippetType="autosnippet"},
      fmt(
        [[
          <InputError class="mt-2{}" :message="form.errors.{}" />
        ]],
        {
          i(2),
          i(1),
        }
      ),
      {condition = line_begin}
    ),

  }
