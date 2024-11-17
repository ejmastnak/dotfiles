local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- include header, choice between global and local
    s({trig = "inn", snippetType="autosnippet"},
      fmt(
        [[#include {}]],
        { 
          c(1, {
            sn(nil, {t("<"), d(1, get_visual), t(".h>")}), 
            sn(nil, {t('"'), d(1, get_visual), t('.h"')}), 
          }),
        }
      ),
      {condition = line_begin}
    ),
    -- include stdio
    s({trig = "iio", snippetType="autosnippet"},
      { t('#include <stdio.h>') },
      {condition = line_begin}
    ),
    -- include math
    s({trig = "imm", snippetType="autosnippet"},
      { t('#include <math.h>') },
      {condition = line_begin}
    ),
    -- include stdlib
    s({trig = "ilib", snippetType="autosnippet"},
      { t('#include <stdlib.h>') },
      {condition = line_begin}
    ),
    -- include string
    s({trig = "istr", snippetType="autosnippet"},
      { t('#include <string.h>') },
      {condition = line_begin}
    ),
    -- include limits
    s({trig = "ill", snippetType="autosnippet"},
      { t('#include <limits.h>') },
      {condition = line_begin}
    ),
    -- include PortAudio
    s({trig = "ipa", snippetType="autosnippet"},
      { t('#include <portaudio.h>') },
      {condition = line_begin}
    ),
    -- include libsndfile
    s({trig = "isf", snippetType="autosnippet"},
      { t('#include <sndfile.h>') },
      {condition = line_begin}
    ),
    -- include asoundlib
    s({trig = "isl", snippetType="autosnippet"},
      { t('#include <alsa/asoundlib.h>') },
      {condition = line_begin}
    ),
    -- define M_PI if not defined
    s({trig = "MPI", snippetType="autosnippet"},
      fmt(
        [[
        #ifndef M_PI
        #define M_PI 3.14159265358979323846264338
        #endif
        ]],
        {
        }
      ),
      {condition = line_begin}
    ),
  }
