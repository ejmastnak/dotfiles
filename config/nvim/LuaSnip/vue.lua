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
    s({trig = "lzz", snippetType="autosnippet"},
      fmt(
        [[
          <Link :href="route('{}'{})">{}</Link>
        ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      )
    ),
    -- SCRIPT SETUP
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
    -- TEMPLATE
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
    -- DEFINEPROPS
    s({trig = "vdp", snippetType="autosnippet"},
      fmta(
        [[
          const props = defineProps({
            <>
          })
        ]],
        {
          i(0)
        }
      )
    ),
    -- ON MOUNTED SET TIMEOUT
    s({trig = "onn", snippetType="autosnippet"},
      fmt(
        [[
          onMounted(() => {{
            setTimeout(() => {{
              {}
            }}, {});
          }})
        ]],
        {
          i(2),
          i(1, "1000"),
        }
      )
    ),
    
  }

