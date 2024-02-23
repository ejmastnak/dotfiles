require('luasnip').filetype_extend("vue", {"html", "javascript", "tailwind"})

local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Mustache braces
    s({trig="vv", snippetType="autosnippet"},
      fmta(
        [[
        {{<>}}
        ]],
        {
          d(1, get_visual),
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
    -- v-if directive
    s({trig = "viff", snippetType="autosnippet"},
      fmt(
        [[
          v-if="{}"
        ]],
        {
          i(1)
        }
      )
    ),
    -- href attribute with ziggy route
    s({trig = ";h", snippetType="autosnippet"},
      fmt(
        [[
          :href="route({}{})"
        ]],
        {
          i(1),
          i(2)
        }
      )
    ),
    -- v-if="false"
    s({trig = "vff", snippetType="autosnippet"},
      {t('v-if="false"')}
    ),
    -- onMounted
    s({trig = "onmm", snippetType="autosnippet"},
      fmt(
        [[
          onMounted(() => {
            []
          })
        ]],
        {
          i(1),
        },
        { delimiters = "[]"}
      ),
      {condition = line_begin}
    ),
  }

