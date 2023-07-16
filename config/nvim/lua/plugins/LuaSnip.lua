vim.cmd [[
  " Expand
  imap <silent><expr> <Tab> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<Tab>'

  " Jump forward
  imap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
  smap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'

  " Jump backward
  imap <silent><expr> <C-b> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-j>'
  smap <silent><expr> <C-b> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-j>'

  " Cycle forward through choice nodes with Control-F
  imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
  smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
]]

-- --------------------------------------------- "
local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix
-----------------------------------------------

-- ls.setup({
--   load_ft_func =
--       -- Also load both lua and json when a markdown-file is opened,
--       -- javascript for html.
--       -- Other filetypes just load themselves.
--       require("luasnip.extras.filetype_functions").extend_load_ft({
--           markdown = {"lua", "json"},
--           html = {"javascript"}
--       })
-- })

ls.config.set_config({
  -- Don't store snippet history for less overhead
  history = false,
  -- Allow autotrigger snippets
  enable_autosnippets = true,
  -- For equivalent of UltiSnips visual selection
  store_selection_keys = "<Tab>",
  -- Event on which to check for exiting a snippet's region
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave',
})

-- require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

vim.keymap.set('', '<Leader>U', '<Cmd>lua require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})<CR><Cmd>echo "Snippets refreshed!"<CR>')
