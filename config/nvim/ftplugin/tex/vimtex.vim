" My configuration of the VimTeX plugin

" Only load this plugin it has not yet been loaded for this buffer
if exists("b:did_myvimtexsettings")
  finish
endif
let b:did_myvimtexsettings = 1

" Disabling some default features
let g:vimtex_indent_enabled = 0          " turn off vimtex indentation
let g:vimtex_mappings_enabled = 0        " disable default mappings
let g:vimtex_imaps_enabled = 0           " disable insert mode mappings (I use UltiSnips)
let g:vimtex_complete_enabled = 0        " turn off completion (not currently used so more efficient to turn off)
let g:vimtex_syntax_conceal_disable = 1  " disable syntax conceal

" Default is 500 lines and gave me lags on missed key presses
let g:vimtex_delim_stopline = 5

" vimtex toggle delimeter configuration
" ------------------------------- "
let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\big', '\big'],
  \]

" Don't open quickfix for warning measseges if no errors are present
let g:vimtex_quickfix_open_on_warning = 0  

" Use Zathura as the PDF viewer
let g:vimtex_view_method = 'zathura'


" DEFINE MAPPINGS
" ---------------------------------------------
nmap dse <plug>(vimtex-env-delete)
nmap dsc <plug>(vimtex-cmd-delete)
nmap dsm <plug>(vimtex-env-delete-math)
nmap dsd <plug>(vimtex-delim-delete)
nmap cse <plug>(vimtex-env-change)
nmap csc <plug>(vimtex-cmd-change)
nmap csm <plug>(vimtex-env-change-math)
nmap csd <plug>(vimtex-delim-change-math)
nmap tsf <plug>(vimtex-cmd-toggle-frac)
nmap tsc <plug>(vimtex-cmd-toggle-star)
nmap tse <plug>(vimtex-env-toggle-star)
nmap tsd <plug>(vimtex-delim-toggle-modifier)
nmap tsD <plug>(vimtex-delim-toggle-modifier-reverse)
imap ]] <plug>(vimtex-delim-close)

" Text objects in operator-pending mode
omap ac <plug>(vimtex-ac)
xmap ac <plug>(vimtex-ac)
omap ic <plug>(vimtex-ic)
xmap ic <plug>(vimtex-ic)

omap ad <plug>(vimtex-ad)
xmap ad <plug>(vimtex-ad)
omap id <plug>(vimtex-id)
xmap id <plug>(vimtex-id)

omap ae <plug>(vimtex-ae)
xmap ae <plug>(vimtex-ae)
omap ie <plug>(vimtex-ie)
xmap ie <plug>(vimtex-ie)

omap am <plug>(vimtex-a$)
xmap am <plug>(vimtex-a$)
omap im <plug>(vimtex-i$)
xmap im <plug>(vimtex-i$)

omap aP <plug>(vimtex-aP)
xmap aP <plug>(vimtex-aP)
omap iP <plug>(vimtex-iP)
xmap iP <plug>(vimtex-iP)

omap ai <plug>(vimtex-am)
xmap ai <plug>(vimtex-am)
omap ii <plug>(vimtex-im)
xmap ii <plug>(vimtex-im)

" nvo mode mappings
map %  <plug>(vimtex-%)
map ]] <plug>(vimtex-]])
map ][ <plug>(vimtex-][)
map [] <plug>(vimtex-[])
map [[ <plug>(vimtex-[[)

map ]m <plug>(vimtex-]m)
map ]M <plug>(vimtex-]M)
map [m <plug>(vimtex-[m)
map [M <plug>(vimtex-[M)

map ]n <plug>(vimtex-]n)
map ]N <plug>(vimtex-]N)
map [n <plug>(vimtex-[n)
map [N <plug>(vimtex-[N)

map ]r <plug>(vimtex-]r)
map ]R <plug>(vimtex-]R)
map [r <plug>(vimtex-[r)
map [R <plug>(vimtex-[R)

map ]/ <plug>(vimtex-]/
map ]* <plug>(vimtex-]star
map [/ <plug>(vimtex-[/
map [* <plug>(vimtex-[star
