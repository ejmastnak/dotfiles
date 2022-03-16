" My configuration of the VimTeX plugin

" Only load this plugin it has not yet been loaded for this buffer
if exists("b:did_myvimtexsettings")
  finish
endif
let b:did_myvimtexsettings = 1

map <leader>i :VimtexInfo<CR>

" Disabling some default features
" ---------------------------------------------
" Turn off VimTeX indentation
let g:vimtex_indent_enabled = 0          

" Disable default mappings
let g:vimtex_mappings_enabled = 0        

" Disable insert mode mappings (I use UltiSnips)
let g:vimtex_imaps_enabled = 0           

" Turn off completion (not currently used so more efficient to turn off)
let g:vimtex_complete_enabled = 0        

" Disable syntax conceal
let g:vimtex_syntax_conceal_disable = 1  

" Default is 500 lines and gave me lags on missed key presses
let g:vimtex_delim_stopline = 5

" VimTeX toggle delimeter configuration
" ------------------------------- "
let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\big', '\big'],
  \]

" Don't open quickfix for warning messages if no errors are present
let g:vimtex_quickfix_open_on_warning = 0  

" Disable some compilation warning messages
let g:vimtex_quickfix_ignore_filters = [
      \ 'LaTeX hooks Warning',
      \ 'Underfull \\hbox',
      \ 'Overfull \\hbox',
      \ 'LaTeX Warning: .\+ float specifier changed to',
      \ 'Package siunitx Warning: Detected the "physics" package:',
      \ 'Package hyperref Warning: Token not allowed in a PDF string',
      \]

if g:os_current == "Linux"
  let g:vimtex_view_method = 'zathura'
elseif g:os_current == "Darwin"
  let g:vimtex_view_method = 'skim'
  " let g:vimtex_view_method = 'zathura'
else
  echom "Error: forward show not supported on this OS"
endif

" Don't automatically open PDF viewer after first compilation
let g:vimtex_view_automatic = 0

let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 0,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" Close viewers when VimTeX buffers are closed (see :help vimtex-events)
function! CloseViewers()
  if executable('xdotool')
        \ && exists('b:vimtex.viewer.xwin_id')
        \ && b:vimtex.viewer.xwin_id > 0
    call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
  endif
endfunction

augroup vimtex_event_close
  au!
  au User VimtexEventQuit call CloseViewers()
augroup END

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
