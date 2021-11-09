" configuration options for the vimtex plugin
let g:vimtex_compiler_enabled = 0   " turn off compilation interface
let g:vimtex_view_enabled = 0       " turn off pdf viewer interface
let g:vimtex_indent_enabled = 0     " turn off vimtex indentation
let g:vimtex_imaps_enabled = 0      " turn off insert mode mappings (I use UltiSnips)
let g:vimtex_complete_enabled = 0   " turn off completion (not currently used so more efficient to turn off)

" vimtex toggle delimeter configuration
" ------------------------------- "
let g:vimtex_delim_list = {'mods' : {}}
let g:vimtex_delim_list.mods.name = [
      \ ['\left', '\right'],
      \ ['\mleft', '\mright'],
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \ ['\big', '\big'],
      \ ['\Big', '\Big'],
      \ ['\bigg', '\bigg'],
      \ ['\Bigg', '\Bigg'],
      \]
let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\big', '\big'],
  \]

" default is 500 and often give lags on missed key presses
let g:vimtex_delim_stopline = 5
