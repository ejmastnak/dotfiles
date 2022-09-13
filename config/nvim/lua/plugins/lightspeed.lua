require'lightspeed'.setup { 
  substitute_chars = { ['\r'] = '¬',
    [' '] = '␣',
    ['\t'] = '⇥' },
}

-- Set the keys for Lightspeed operator-pending motions
vim.keymap.set('o', 'r', '<Plug>Lightspeed_s')
vim.keymap.set('o', 'R', '<Plug>Lightspeed_S')

vim.cmd [[

" Setting `;` and `,` to repeat the last Lightspeed motion (s/x or f/t):
" --------------------------------------------- "
let g:lightspeed_last_motion = ''

augroup lightspeed_last_motion
autocmd!
autocmd User LightspeedSxEnter let g:lightspeed_last_motion = 'sx'
autocmd User LightspeedFtEnter let g:lightspeed_last_motion = 'ft'
augroup end

map <expr> ; g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>Lightspeed_;_ft"
map <expr> , g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>Lightspeed_,_ft"
" --------------------------------------------- "

" Color configuration
" --------------------------------------------- "
if !has("termguicolors")
  exit
endif

let s:nord3_bright = "#616E88"
let s:nord6  = "#ECEFF4"
let s:nord7  = "#8FBCBB"
let s:nord12 = "#D08770"

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

exec "highlight LightspeedUniqueChar" .
      \ " gui="   . "bold" .
      \ " guibg=" . "NONE" .
      \ " guifg=" . s:text

" Foreground color of greyed out text during 2-character search
exec "highlight LightspeedGreyWash" .
      \ " gui="   . "NONE" .
      \ " guibg=" . "NONE" . 
      \ " guifg=" . s:greywash
]]
