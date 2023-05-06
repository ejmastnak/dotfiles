require('luasnip').filetype_extend("vue", {"html", "javascript"})

local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- IMPORT VUE FROM CDN
    s({trig = "cdn", snippetType="autosnippet"},
      fmt(
        [[
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        ]],
        {}
      ),
      {condition = line_begin}
    ),
    -- MUSTACHE BRACES
    s({trig = "vv", snippetType="autosnippet"},
      fmta(
        [[
        {{<>}}
        ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Inertia Link using Ziggy route binding
    s({trig = "LL", snippetType="autosnippet"},
      fmt(
        [[
          <Link :href="route({})">{}</Link>
        ]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    -- script setup
    s({trig = "vss", snippetType="autosnippet"},
      fmt(
        [[
          <script setup>
          {}
          </script>
        ]],
        {
          i(0)
        }
      )
    ),
    -- template
    s({trig = "vtt", snippetType="autosnippet"},
      fmt(
        [[
          <template>
            {}
          </template>
        ]],
        {
          i(0)
        }
      )
    ),
    -- defineProps
    s({trig = "vdp", snippetType="autosnippet"},
      fmta(
        [[
          const props = defineProps({
            <>
          })
        ]],
        {
          i(1)
        }
      )
    ),
    -- Import and set a persistent layout
    s({trig = "layout"},
      fmt(
        [[
          <script>
          import () from "@/Layouts/().vue";
          export default {
            layout: (),
          }
          </script>
        ]],
        {
          i(1, "AppLayout"),
          rep(1),
          rep(1),
        },
        { delimiters = "()"}
      ),
      {condition = line_begin}
    ),
    -- Head meta tag
    s({trig = "hh", snippetType="autosnippet"},
      fmt(
        [[
          <Head title="{}" />
        ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
  }

