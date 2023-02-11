local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- RUN HUGO SERVER
    s({trig = "hugo"},
      fmta(
        [[
        {
          "name": "Project",
          "cmd": "xdg-open http://localhost:1313/ && hugo serve --enableGitInfo",
          "tags": ["project"],
          "count": <>
        }
        ]],
        {
          i(1, "1")
        }
      )
    ),
    -- COMPILE TAILWIND
    s({trig = "tw"},
      fmta(
        [[
        {
          "name": "Compile Tailwind CSS",
          "cmd": "npm run compile-tailwind",
          "tags": ["compile"],
          "count": <>
        }
        ]],
        {
          i(1, "2")
        }
      )
    ),
    -- PHP ARTISAN SERVE
    s({trig = "php"},
      fmta(
        [[
        {
          "name": "Project",
          "cmd": "xdg-open http://127.0.0.1:8000/ && php artisan serve",
          "tags": ["project"],
          "count": <>
        }
        ]],
        {
          i(1, "2")
        }
      )
    ),
    -- NPM RUN DEV
    s({trig = "dev"},
      fmta(
        [[
        {
          "name": "Run",
          "cmd": "npm run dev",
          "tags": ["project"],
          "count": <>
        }
        ]],
        {
          i(1, "2")
        }
      )
    ),
  }


    

    
