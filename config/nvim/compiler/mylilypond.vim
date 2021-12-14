" Settings for compiling LaTeX documents
if exists("current_compiler")
	finish
endif
let current_compiler = "mylilypond"

" Begin with a universal lilypond command and build up from there
let s:program = 'lilypond'

" Disable inverse search hyperlinks on macOS, where they don't work
if g:os_current == "Darwin"
  let s:program = s:program . ' -dno-point-and-click'
endif
let s:program = s:program . ' %'

" Set makeprg
let &l:makeprg = expand(s:program)

" Set errorformat
" ---------------------------------------------
setlocal errorformat=%f:%l:%c:\ %m
setlocal errorformat+=%f:%l:\ %m
setlocal errorformat+=In\ file\ included\ from\ %f:%l:
setlocal errorformat+=\^I\^Ifrom\ %f:%l%m
