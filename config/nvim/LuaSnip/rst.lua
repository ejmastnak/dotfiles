local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

-- Used to insert a ReST heading into a document; uses the second argument
-- `char` as the ReST underline for the heading.
function insert_heading(heading_text, char)
  -- Column and line number of current cursor position
  local l,c = unpack(vim.api.nvim_win_get_cursor(0))

  -- For whatever reason nvim_win_set_cursor works as expected only with cursor
  -- on the last line of the buffer, hence the separate cases. Yucky but eh.
  local lines_in_buf = vim.api.nvim_buf_line_count(0)
  if l == lines_in_buf then
    vim.api.nvim_buf_set_lines(0, l-1, l, false, {heading_text, string.rep(char, #heading_text), ""})
    vim.api.nvim_win_set_cursor(0, {l+2, 0})
  else
    vim.api.nvim_buf_set_lines(0, l-1, l, false, {heading_text, string.rep(char, #heading_text), ""})
    local up = vim.api.nvim_replace_termcodes("<Up>", true, false, true)
    vim.api.nvim_feedkeys(up, 'i', false)
  end

end

return
  {
    -- Inline code block, overrides single paired back ticks for "all" filetype
    s({trig="sd", snippetType="autosnippet", priority=1000},
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("``"),
        d(1, get_visual),
        t("``"),
      }),
    -- Italic (emphasized) text
    s({trig="tii", snippetType="autosnippet"},
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("*"),
        d(1, get_visual),
        t("*"),
      }),
    -- Bold text
    s({trig="tbb", snippetType="autosnippet"},
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("**"),
        d(1, get_visual),
        t("**"),
      }),
    -- Code block
    s({trig="cc", snippetType="autosnippet"},
      fmt(
        [[
          .. code-block:: {}

            {}
        ]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    -- Inline hyperlink capturing display text
    s({trig="LL", snippetType="autosnippet"},
      fmt(
        [[`{} <{}>`_]],
        {
          d(1, get_visual),
          i(2),
        }
      )
    ),
    -- Inline hyperlink capturing URL
    s({trig="LU", snippetType="autosnippet"},
      fmt(
        [[`{} <{}>`_]],
        {
          i(1),
          d(2, get_visual),
        }
      )
    ),
    -- Hack to remove indentation in bulleted lists
    s({trig="  --", snippetType="autosnippet"},
      {t("- ")},
      {condition = line_begin}
    ),
    s({trig="   ##", snippetType="autosnippet"},
      {t("#. ")},
      {condition = line_begin}
    ),
    -- Heading
    s({trig="h1", snippetType="autosnippet"},
      {i(1)},
      {
        condition = line_begin,
        callbacks = {
          [1] = {
            [events.leave] = function(node, _event_args) 
              insert_heading(table.concat(node:get_text(), "\n"), "=")
            end
          }
        }
      }
    ),
    -- Heading
    s({trig="h2", snippetType="autosnippet"},
      {i(1)},
      {
        condition = line_begin,
        callbacks = {
          [1] = {
            [events.leave] = function(node, _event_args) 
              insert_heading(table.concat(node:get_text(), "\n"), "-")
            end
          }
        }
      }
    ),
    -- Heading
    s({trig="h3", snippetType="autosnippet"},
      {i(1)},
      {
        condition = line_begin,
        callbacks = {
          [1] = {
            [events.leave] = function(node, _event_args) 
              insert_heading(table.concat(node:get_text(), "\n"), "^")
            end
          }
        }
      }
    ),
    -- Label for cross-referencing
    s({trig="lbl", snippetType="autosnippet"},
      fmt(
        [[
          .. _{}:
        ]],
        {
          d(1, get_visual),
        }
      ),
      { condition = line_begin }
    ),
    -- Reference a label
    s({trig="RR", snippetType="autosnippet"},
      fmt(
        [[
          :ref:`{} <{}>`
        ]],
        {
          d(1, get_visual),
          i(2, "label")
        }
      )
    ),
  }
