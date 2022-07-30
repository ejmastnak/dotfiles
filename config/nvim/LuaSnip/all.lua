return
-- Manually triggered snippets
{
},
-- Autotriggered
{
  s({trig="("},
    {
      t("("),
      i(1, "Hello"),
      f(function(args, snip) return snip.env.SELECT_RAW end, {}),
      t(")"),
    }),
}
