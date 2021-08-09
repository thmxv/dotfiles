set termguicolors   " Use true colors
set background=dark " BEFORE colorscheme

if(!has("nvim"))
  packadd vim-solarized8
  colorscheme solarized8
else
  packadd nvim-solarized-lua
  colorscheme solarized
endif
