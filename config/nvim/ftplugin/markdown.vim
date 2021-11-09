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

noremap <silent><leader>v :MarkdownPreview<cr>
noremap <leader>tm i## Contents<esc>:GenTocMarked<cr>
noremap <leader>x :syntax sync fromstart<cr>
