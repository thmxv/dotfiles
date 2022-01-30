
" Quick open/reload settings
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>

" Clear search higlight on ESC
nnoremap <esc> :noh<return><esc>

" Buffer delete without closing split
" nnoremap <leader>bd :b#\|bd#<CR>
nnoremap <leader>bd :Bdelete<CR>

" Neo-vim only
if(has("nvim"))

  " Telescope
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  nnoremap <leader>fr <cmd>Telescope lsp_references<cr>

endif

