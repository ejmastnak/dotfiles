" M3U playlist files
" I just use shell filetype for syntax highlighting
autocmd! BufNewFile,BufRead *.m3u	set filetype=sh

" Configuration
au BufNewFile,BufRead *.conf set filetype=conf

" Lilypond
au! BufNewFile,BufRead *.ly	set filetype=lilypond

" LyTeX
autocmd! BufNewFile,BufRead *.lytex	set filetype=lytex

" AnkiTeX
autocmd! BufNewFile,BufRead *.ankitex	set filetype=ankitex

" Matplotlib stylesheets
au! BufNewFile,BufRead *.mplstyle	set filetype=yaml

" VIFM
au BufNewFile,BufRead *.vifm set filetype=vim
