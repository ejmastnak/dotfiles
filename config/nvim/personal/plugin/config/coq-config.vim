" configuring global coq.nvim settings
lua << EOF
vim.g.coq_settings = {
  keymap = {
    recommended = false,
    pre_select = true,
  },
	clients = {
		third_party = {
			enabled = false,
		},
		tmux = {
			enabled = false,
		},
		tree_sitter = {
			enabled = false,
		},
		snippets = {
			enabled = false,
		},
		tags = {
			enabled = false,
		},
	},
}
EOF

" Setting keybindings
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
ino <silent><expr> <CR> pumvisible() ? (complete_info().selected == -1 ? "\<C-e><C-y>" : "\<C-y>") : "\<CR>"

" " START BUFFER TEST
" " -----------------------------
" lua << EOF
" vim.g.coq_settings = {
" 	clients = {
" 		buffers = {
" 			short_name = "BBB",
" 		},
" 		lsp = {
" 			short_name = "SSS",
" 		},
" 	},
" }
" EOF
" " -----------------------------
" " END BUFFER TEST
