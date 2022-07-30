" Basically porting some VimTeX features for use when editing Anki notes that use LaTeX

" Set tex_flavor for the VimTeX plug
let g:tex_flavor = 'latex'

" Source the same VimTeX plugin settings I use for LaTeX
source ~/.config/nvim/ftplugin/tex/vimtex.vim

" Load features from the VimTeX plugin
call vimtex#init()
