set nocompatible    " Modern vim

set encoding=utf-8  " Terminal encoding
set colorcolumn=80  " Right margin at 80 char
set tabstop=4
set number
set nowrap
set showmatch       " Show matching parenthesis
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
set relativenumber


" Source other config files
source ~/.vim/key-mappings.vim
source ~/.vim/color-theme.vim
source ~/.vim/terminal.vim
source ~/.vim/airline.vim
source ~/.vim/clang-format.vim
source ~/.vim/nerdtree.vim
source ~/.vim/nerdcommenter.vim

if(!has("nvim"))
  " Vim only

else
  " Neovim only
  packadd nvim-lspconfig
  packadd nvim-lspinstall
  packadd nvim-treesitter
  packadd telescope.nvim
  packadd telescope-fzy-native.nvim
  packadd nvim-compe

  " Source other config files
  luafile ~/.vim/treesitter.lua
  luafile ~/.vim/lsp.lua
  luafile ~/.vim/compe.lua
  luafile ~/.vim/telescope.lua

endif
