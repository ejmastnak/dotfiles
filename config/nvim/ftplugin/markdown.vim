" settings for the markdown-preview.nvim plugin
let g:mkdp_refresh_slow = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 1,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

noremap <buffer> <silent><leader>v :MarkdownPreview<cr>
" noremap <buffer> <leader>tm i## Contents<esc>:GenTocGFM<cr>
noremap <buffer> <leader>x :syntax sync fromstart<cr>

setlocal expandtab
setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Disable default key mappings for the textobj_markdown plugin
" I set my own in after/ftplugin/
let g:textobj_markdown_no_default_key_mappings = 1
