" Settings for working with lytex files, which combine LilyPond and LaTeX

" set tex_flavor for the vimtex plug
let g:tex_flavor = 'latex'

" source the same vimtex plugin settings I use for LaTeX
source ~/.config/nvim/ftplugin/tex/vimtex.vim

" load features from the vimtex plugin
call vimtex#init()

omap <silent><buffer> ie <plug>(vimtex-ie)
omap <silent><buffer> ae <plug>(vimtex-ae)
xmap <silent><buffer> ie <plug>(vimtex-ie)
xmap <silent><buffer> ae <plug>(vimtex-ae)

nmap <silent><buffer> dsc <plug>(vimtex-cmd-delete)
