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

" Quick open/reload settings
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>
" Clear search higlight on ESC
nnoremap <esc> :noh<return><esc>

" Terminal navigation utilities
" tnoremap <Esc> <C-\><C-n>:set number<CR>
tnoremap <Esc> <C-\><C-n>
"tnoremap <M-[> <Esc>
"tnoremap <C-v><Esc> <Esc>
if(exists("##TermOpen"))
  autocmd TermOpen * setlocal nonumber norelativenumber
endif
if(exists("##TermEnter"))
  autocmd TermEnter * setlocal nonumber norelativenumber
endif
if(exists("##TerminalOpen"))
  autocmd TermOpen * setlocal nonumber norelativenumber
endif
if(exists("##TerminalEnter"))
  autocmd TermEnter * setlocal nonumber norelativenumber
endif
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l
vnoremap <C-h> <Esc><C-w>h
vnoremap <C-j> <Esc><C-w>j
vnoremap <C-k> <Esc><C-w>k
vnoremap <C-l> <Esc><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>t :split \| ter<CR>a
nnoremap <leader>vt :vsplit \| ter<CR>a

" Theme
set termguicolors   " Use true colors
set background=dark
colorscheme solarized8
" Statusbar theme
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

" make term load bashrc
let &shell='/usr/bin/bash --login'

" airline config
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" NERDree config
" Ctrl+n
map <C-n> :<C-u>NERDTreeToggle<CR>
" Exit if last window is NERDTree
autocmd bufenter *
    \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
    \ | q
    \ | endif
" Open automatically if no file is given or opening a directory
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter *
    \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
    \ | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0]
    \ | endif
" arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" NERD commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" Tagbar
nmap <F8> :<C-u>TagbarOpenAutoClose<CR>

" Run clang-format on save
function! Formatonsave()
  let l:formatdiff = 1
  pyf /usr/share/clang/clang-format.py
endfunction
" autocmd BufWritePre *.h,*.cc,*.cpp,*.cxx call Formatonsave()

" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  }
}
EOF

" nvim-lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" source ~/.vim/coc.vim

