local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- Local constants file
    s({trig = "icc", snippetType="autosnippet"},
      {t("import constants")},
      {condition = line_begin}
    ),
    -- Numpy
    s({trig = "inpp", snippetType="autosnippet"},
      {t("import numpy as np")},
      {condition = line_begin}
    ),
    -- Matplotlib
    s({trig = "impl", snippetType="autosnippet"},
      {t("import matplotlib.pyplot as plt")},
      {condition = line_begin}
    ),
    -- Pandas
    s({trig = "ipdd", snippetType="autosnippet"},
      {t("import pandas as pd")},
      {condition = line_begin}
    ),
    -- sounddevice
    s({trig = "isdd", snippetType="autosnippet"},
      {t("import sounddevice as sd")},
      {condition = line_begin}
    ),
    -- pathlib
    s({trig = "ipll", snippetType="autosnippet"},
      {t("from pathlib import Path")},
      {condition = line_begin}
    ),
  }
