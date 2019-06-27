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
"set visualbell      " No beep
"set noerrorbells    " No beep

" Theme
set termguicolors   " Use true colors
set background=dark
colorscheme solarized8
" Statusbar theme
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

" NERDree config
" Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Exit if last window is NERDTree
autocmd bufenter *
    \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
    \ | q
    \ | endif
" Open automatically if not file is given or opening a directory
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter *
    \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
    \ | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0]
    \ | endif
" arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Tagbar
nmap <F8> :TagbarToggle<CR>

