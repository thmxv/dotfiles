" Modern vim
set nocompatible

" Pathogen plugins and scripts manager
" Install plugins/scrypts by copying into in ~/.vim/bundle/
execute pathogen#infect()

"Personal Config
set encoding=utf-8
set colorcolumn=80
set number
set nowrap
set noshowmode  " Mode already in statusbar
set mouse=a
set listchars=tab:→\ ,trail:·,precedes:«,extends:»,eol:¶
set list        " Disply hidden control char

" Theme
set termguicolors
set background=dark
colorscheme solarized8
" Statusbar theme
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

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

