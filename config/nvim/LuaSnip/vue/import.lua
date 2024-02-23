require('luasnip').filetype_extend("vue", {"html", "javascript"})

local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Import from Components
    s({trig = "icc", snippetType="autosnippet"},
      fmt(
        [[
          import {} from '@/Components/{}.vue'
        ]],
        { 
          i(1),
          rep(1)
        }
      )
    ),
    -- Import from Shared
    s({trig = "iss", snippetType="autosnippet"},
      fmt(
        [[
          import {} from '@/Shared/{}.vue'
        ]],
        { 
          i(1),
          rep(1)
        }
      )
    ),
    -- Import from Layouts
    s({trig = "ial", snippetType="autosnippet"},
      fmt(
        [[
          import {} from "@/Layouts/{}.vue";
        ]],
        { 
          i(1),
          rep(1)
        }
      )
    ),
    -- Import from local Partials
    s({trig = "ipp", snippetType="autosnippet"},
      fmt(
        [[
          import {} from './Partials/{}.vue'
        ]],
        { 
          i(1),
          rep(1)
        }
      )
    ),
    -- Import a heroicons icon
    s({trig = "ihi", snippetType="autosnippet"},
      fmta(
        [[
          import { <> } from '@heroicons/vue/24/outline'
        ]],
        { i(1) }
      )
    ),
    -- Import from Inertia
    s({trig = "ivi", snippetType="autosnippet"},
      fmta(
        [[
          import { <> } from '@inertiajs/vue3'
        ]],
        { i(1) }
      )
    ),
    -- Import from Vue
    s({trig = "ivv", snippetType="autosnippet"},
      fmta(
        [[
          import { <> } from 'vue'
        ]],
        { i(1) }
      )
    ),
    -- Import from global utility functions
    s({trig = "igf", snippetType="autosnippet"},
      fmta(
        [[
          import { <> } from '@/utils/GlobalFunctions.js'
        ]],
        { i(1) }
      )
    ),
  }






