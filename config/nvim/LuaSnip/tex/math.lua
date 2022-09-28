local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

-- Math context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
-- MANUALLY TRIGGERED SNIPPETS
{},
-- AUTOTRIGGERED SNIPPETS
{

  -- SUPERSCRIPT
  s({trig = "([%a%)%]%}])'", regTrig = true, wordTrig = false},
    fmta(
      "<>^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- SUBSCRIPT
  s({trig = "([%a%)%]%}]);", regTrig = true, wordTrig = false},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- SUBSCRIPT AND SUPERSCRIPT
  s({trig = "([%a%)%]%}])__", regTrig = true, wordTrig = false},
    fmta(
      "<>^{<>}_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- TEXT SUBSCRIPT
  s({trig = '([%a%)%]%}])sd', regTrig = true, wordTrig = false},
    fmta(
      "<>_{\\mathrm{<>}}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual)
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- SUPERSCRIPT SHORTCUT
  -- Places the first alphanumeric character after the trigger into a superscript.
  s({trig = '([%a%)%]%}])"([%w])', regTrig = true, wordTrig = false},
    fmta(
      "<>^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end ),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- EULER'S NUMBER SUPERSCRIPT SHORTCUT
  s({trig = '([^%a])ee', regTrig = true, wordTrig = false},
    fmta(
      "<>e^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual)
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- SUBSCRIPT SHORTCUT
  -- Places the first alphanumeric character after the trigger into a subscript.
  s({trig = '([%a%)%]%}]):([%w])', regTrig = true, wordTrig = false},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        f( function(_, snip) return snip.captures[2] end ),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- ZERO SUBSCRIPT SHORTCUT
  s({trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("0")
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- J SUBSCRIPT SHORTCUT (since jk triggers snippet jump forward)
  s({trig = '([%a%)%]%}])JJ', regTrig = true, wordTrig = false},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("j")
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- VECTOR, i.e. \vec
  s({trig = "([^%a])vv", regTrig = true, wordTrig = false},
    fmta(
      "<>\\vec{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- DEFAULT UNIT VECTOR WITH SUBSCRIPT, i.e. \unitvector_{}
  s({trig = "([^%a])ue", regTrig = true, wordTrig = false},
    fmta(
      "<>\\unitvector_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- UNIT VECTOR WITH HAT, i.e. \uvec{}
  s({trig = "([^%a])uv", regTrig = true, wordTrig = false},
    fmta(
      "<>\\uvec{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- FRACTION
  s({trig = "([^%a])ff", regTrig = true, wordTrig = false},
    fmta(
      "<>\\frac{<>}{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
        i(2, ""),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- ABSOLUTE VALUE
  s({trig = "([^%a])aa", regTrig = true, wordTrig = false},
    fmta(
      "<>\\abs{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- SQUARE ROOT
  s({trig = "([^%a])sq", regTrig = true, wordTrig = false},
    fmta(
      "<>\\sqrt{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- DERIVATIVE with denominator only
  s({trig = "([^%a])dV", regTrig = true, wordTrig = false},
    fmta(
      "<>\\dvOne{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- DERIVATIVE with numerator and denominator
  s({trig = "([^%a])dvv", regTrig = true, wordTrig = false},
    fmta(
      "<>\\dv{<>}{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2)
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- DERIVATIVE with numerator, denominator, and higher-order argument
  s({trig = "([^%a])ddv", regTrig = true, wordTrig = false},
    fmta(
      "<>\\dvN{<>}{<>}{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2),
        i(3),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- PARTIAL DERIVATIVE with denominator only
  s({trig = "([^%a])pV", regTrig = true, wordTrig = false},
    fmta(
      "<>\\pdvOne{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- PARTIAL DERIVATIVE with numerator and denominator
  s({trig = "([^%a])pvv", regTrig = true, wordTrig = false},
    fmta(
      "<>\\pdv{<>}{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2)
      }
    ),
    {condition = tex.in_mathzone}
  ),
  -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
  s({trig = "([^%a])ppv", regTrig = true, wordTrig = false},
    fmta(
      "<>\\pdvN{<>}{<>}{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2),
        i(3),
      }
    ),
    {condition = tex.in_mathzone}
  ),

  --
  -- BEGIN STATIC SNIPPETS
  --

  -- DIFFERENTIAL, i.e. \diff
  s({trig = "df"},
    {
      t("\\diff"),
    },
    {condition = tex.in_mathzone}
  ),
  -- BASIC INTEGRAL SYMBOL, i.e. \int
  s({trig = "in1"},
    {
      t("\\int"),
    },
    {condition = tex.in_mathzone}
  ),
  -- DOUBLE INTEGRAL, i.e. \iint
  s({trig = "in2"},
    {
      t("\\iint"),
    },
    {condition = tex.in_mathzone}
  ),
  -- TRIPLE INTEGRAL, i.e. \iiint
  s({trig = "in3"},
    {
      t("\\iiint"),
    },
    {condition = tex.in_mathzone}
  ),
  -- CLOSED SINGLE INTEGRAL, i.e. \oint
  s({trig = "oi1"},
    {
      t("\\oint"),
    },
    {condition = tex.in_mathzone}
  ),
  -- CLOSED DOUBLE INTEGRAL, i.e. \oiint
  s({trig = "oi2"},
    {
      t("\\oiint"),
    },
    {condition = tex.in_mathzone}
  ),
  -- SINE FUNCTION, i.e. \sine
  s({trig = "ss"},
    {
      t("\\sin"),
    },
    {condition = tex.in_mathzone}
  ),
  -- COSINE FUNCTION, i.e. \cosine
  s({trig = "cc"},
    {
      t("\\cos"),
    },
    {condition = tex.in_mathzone}
  ),
  -- GRADIENT OPERATOR, i.e. \grad
  s({trig = "gdd"},
    {
      t("\\grad "),
    },
    {condition = tex.in_mathzone}
  ),
  -- CURL OPERATOR, i.e. \curl
  s({trig = "cll"},
    {
      t("\\curl "),
    },
    {condition = tex.in_mathzone}
  ),
  -- DIVERGENCE OPERATOR, i.e. \divergence
  s({trig = "DI"},
    {
      t("\\div "),
    },
    {condition = tex.in_mathzone}
  ),
  -- LAPLACIAN OPERATOR, i.e. \laplacian
  s({trig = "laa"},
    {
      t("\\laplacian "),
    },
    {condition = tex.in_mathzone}
  ),
  -- SUBSET, i.e. \subset
  s({trig = "sbb"},
    {
      t("\\subset "),
    }
  ),
  -- COLON, i.e. \colon
  s({trig = "::"},
    {
      t("\\colon "),
    }
  ),
  -- IMPLIES, i.e. \implies
  s({trig = ">>"},
    {
      t("\\implies "),
    }
  ),
  -- DOT PRODUCT, i.e. \cdot
  s({trig = ",."},
    {
      t("\\cdot "),
    }
  ),
  -- CROSS PRODUCT, i.e. \times
  s({trig = "xx"},
    {
      t("\\times "),
    }
  ),
}
