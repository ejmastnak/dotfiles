" This is a hack to force the catch-all %-G%.%# that removes unmatched lines
" There are two problems:
" 1. vim-dispatch intentionally removes the original catch-all; see https://github.com/tpope/vim-dispatch/issues/76#issuecomment-50210286
" 2. Vim "helpfully" filters out errorformat duplicates; setting errorformat+=%-G%.%#
"    wouldn't work, so errorformat+=%-G%.%#,. where the appending ,. does nothing is
"    a hack to force in an extra catchall.
setlocal errorformat+=%-G%.%#,.
