if !has("termguicolors")
  exit
endif

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

let s:primary   = s:nord12
let s:secondary = s:nord7
let s:text      = s:nord6
let s:greywash  = s:nord3_bright

" Primary target labels (formally, the character used to jump to a match
" position after the entire 2-character search pattern is typed) 
" Underlined, bold, no background, colored text
exec "highlight LightspeedLabel" .
      \ " gui="   . "bold,underline" .
      \ " guibg=" . "NONE" .
      \ " guifg=" . s:primary

" Secondary target labels, used when all primary target labels are used up
" Underlined, bold, no background, colored text
exec "highlight LightspeedLabelDistant" .
      \ " gui="   . "bold,underline" .
      \ " guibg=" . "NONE" .
      \ " guifg=" . s:secondary

" Shortcut labels (formally, the character used to jump to a match position
" after only the first character in a 2-character search pattern is typed)
" Bold, colored background, white text
exec "highlight LightspeedShortcut" .
      \ " gui="   . "bold" .
      \ " guibg=" . s:primary .
      \ " guifg=" . s:text

" Unlabeled matches (formally, characters that can be jumped to immediately
" after launching a two-character search, i.e. without specifying any search chars)
" Bold, colored background, white text
exec "highlight LightspeedUnlabeledMatch" .
      \ " gui="   . "bold" .
      \ " guibg=" . "NONE" .
      \ " guifg=" . s:text

" Foreground color of greyed out text during 2-character search
exec "highlight LightspeedGreyWash" .
      \ " gui="   . "NONE" .
      \ " guibg=" . "NONE" . 
      \ " guifg=" . s:greywash
