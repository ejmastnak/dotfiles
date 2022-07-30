if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "lilypond"

exec "syntax keyword LightspeedKeyword " .
      \ "Lightspeed " .
      \ "lightspeed " .
      \ "foo " .
      \ "bar "

let s:nord0 = "#2E3440"
let s:nord1 = "#3B4252"
let s:nord2 = "#434C5E"
let s:nord3 = "#4C566A"
let s:nord3_bright = "#616E88"
let s:nord4 = "#D8DEE9"
let s:nord5 = "#E5E9F0"
let s:nord6  = "#ECEFF4"
let s:nord7  = "#8FBCBB"
let s:nord8  = "#88C0D0"
let s:nord9  = "#81A1C1"
let s:nord10 = "#5E81AC"
let s:nord11 = "#BF616A"
let s:nord12 = "#D08770"
let s:nord13 = "#EBCB8B"
let s:nord14 = "#A3BE8C"
let s:nord15 = "#B48EAD"

exec "highlight LightspeedKeyword" .
      \ " gui="   . "bold,underline" .
      \ " guibg=" . "NONE" .
      \ " guifg=" . s:nord8

exec "highlight Normal" .
      \ " gui="   . "NONE" .
      \ " guibg=" . "NONE" .
      \ " guifg=" . s:nord3_bright
