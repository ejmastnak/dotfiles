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
    -- LARAVEL projects
    s({trig = "laravel"},
      fmta(
        [[
        {
          "tasks": [
            {
              "name": "Start PHP server",
              "cmd": "php artisan serve",
              "tags": ["project"],
              "count": 1
            },
            {
              "name": "Run",
              "cmd": "npm run dev",
              "tags": ["project"],
              "count": 2
            },
            {
              "name": "Open browser",
              "cmd": "xdg-open http://127.0.0.1:8000",
              "tags": ["view"],
              "count": 3
            }
          ]
        }
        ]],
        { }
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


    

    
