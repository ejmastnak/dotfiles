" Based on Option C of `:help ftdetect` 
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  " M3U playlist files
  " I just use shell filetype for syntax highlighting
  au! BufNewFile,BufRead *.m3u	set filetype=sh

  " Configuration
  au BufNewFile,BufRead *.conf set filetype=conf

  " Lilypond
  au! BufNewFile,BufRead *.ly	set filetype=lilypond

  " LyTeX
  au! BufNewFile,BufRead *.lytex	set filetype=lytex

  " AnkiTeX
  au! BufNewFile,BufRead *.ankitex	set filetype=ankitex

  " Matplotlib stylesheets
  au! BufNewFile,BufRead *.mplstyle	set filetype=yaml

  " VIFM
  au BufNewFile,BufRead *.vifm set filetype=vim

  " SQlite
  au BufNewFile,BufRead *.sqlite set filetype=sqlite

  " GPG
  au BufNewFile,BufRead *.gpg set filetype=gpg
augroup END
