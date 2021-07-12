set termguicolors   " Use true colors
set background=dark
if(!has("nvim"))
  packadd vim-solarized8
  colorscheme solarized8
else
  colorscheme solarized
endif

" Statusbar theme
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

