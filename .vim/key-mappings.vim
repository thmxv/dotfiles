
" Quick open/reload settings
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>

" Clear search higlight on ESC
nnoremap <esc> :noh<return><esc>

" Tagbar
nmap <F8> :<C-u>TagbarOpenAutoClose<CR>

" NERDTree
map <C-n> :<C-u>NERDTreeToggle<CR>


" Neo-vim only
if(has("nvim"))

  " Telescope
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>

endif

