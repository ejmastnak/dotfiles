" UltiSnips Snippet keys
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "jk"
let g:UltiSnipsJumpBackwardTrigger = "<c-j>"

let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

nnoremap <leader>U <Cmd>call UltiSnips#RefreshSnippets()<CR>
