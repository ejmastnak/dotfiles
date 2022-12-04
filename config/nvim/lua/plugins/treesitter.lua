local disable_for_markdown = function(lang, bufnr)
  return lang == "markdown"
end

local disable_for_large_markdown = function(lang, bufnr)
  return lang == "markdown" and vim.api.nvim_buf_line_count(bufnr) > 500
end

local disable_for_lua = function(lang, bufnr)
  return lang == "lua"
end

local disable_indent = function(lang, bufnr)
  return lang == "python" or disable_for_large_markdown(lang, bufnr)
end

local disable_textobjects = function(lang, bufnr)
  return lang == "python" or lang == "markdown"
end


require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "python", "vim"},

  highlight = {
    enable = true,
    disable = disable_for_large_markdown,
  },
  indent = {
    enable = true,
    disable = disable_indent,
  },
  textobjects = {
    select = {
      enable = true,
      disable = disable_textobjects,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ac"] = "@comment.outer",
        ["ic"] = "@comment.inner",
      },
    },
    move = {
      enable = true,
      disable = disable_for_markdown,

      -- Set jumps in the jumplist
      set_jumps = true, 
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
      },
    },
   },
}
