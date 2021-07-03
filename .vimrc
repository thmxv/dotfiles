set nocompatible    " Modern vim

set encoding=utf-8  " Terminal encoding
set colorcolumn=80  " Right margin at 80 char
set tabstop=4
set number
set nowrap
set showmatch       " Show matching parenthesis
set noshowmode      " Mode already in statusbar
set mouse=a
set listchars=tab:→\ ,trail:·,precedes:«,extends:»,eol:⏎
"set list            " Display above hidden control char
set hidden          " Allow openning/switch buffer when current buffer is edited
"set ignorecase      " Ignore case for search
set history=50      " Commands in search history
set undolevels=1000 " Levels of undo
set title           " Change terminal's title
set visualbell      " No beep
"set noerrorbells    " No beep
set cursorline
set splitright
set splitbelow

" Key mapping
" Quick open/reload settings
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>
" Clear search higlight on ESC
nnoremap <esc> :noh<return><esc>
" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Tagbar
nmap <F8> :<C-u>TagbarOpenAutoClose<CR>

" Source other config files
source ~/.vim/color-theme.vim
source ~/.vim/terminal.vim
source ~/.vim/airline.vim
source ~/.vim/clang-format.vim
source ~/.vim/nerdtree.vim
source ~/.vim/nerdcommenter.vim
if(has("nvim"))
  luafile ~/.vim/treesitter.lua
  luafile ~/.vim/lsp.lua
endif

