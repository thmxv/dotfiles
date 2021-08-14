local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- paq-nvim bootstraping
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git',
    'clone',
    '--depth=1',
    'https://github.com/savq/paq-nvim.git',
    install_path
  })
end

-- paq-nvim packages
require("paq")({
     -- Let Paq manage itself
    "savq/paq-nvim";

    "neovim/nvim-lspconfig";
    "kabouzeid/nvim-lspinstall";
    "glepnir/lspsaga.nvim";
    "hrsh7th/nvim-compe";
    {"nvim-treesitter/nvim-treesitter", run=':TSUpdate'};
    "nvim-telescope/telescope.nvim";
    "nvim-telescope/telescope-fzy-native.nvim";
    "tpope/vim-sensible";
    "tpope/vim-sleuth";
    "tpope/vim-surround";
    "tpope/vim-repeat";
    "tpope/vim-fugitive";
    "scrooloose/nerdcommenter";
    "raimondi/delimitmate";
    "qpkorr/vim-bufkill";
    "ishan9299/nvim-solarized-lua";
    "hoob3rt/lualine.nvim";
    {"a-vrma/black-nvim", run=' '};
})

opt.colorcolumn = '80'
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.showmatch = true            -- Show matching parenthesis
opt.mouse = 'a'
opt.listchars = {
  tab='→\\',
  trail='·',
  precedes='«',
  extends='»',
  eol='⏎',
}
-- opt.list = true              -- Display above hidden control char
opt.hidden = true               -- Allow openning/switch buffer when current buffer is edited
--opt.ignorecase = true         -- Ignore case for search
opt.history = 50                -- Commands in search history
opt.undolevels = 1000           -- Levels of undo
opt.title = true                -- Change terminal's title
opt.visualbell = true           -- No beep
--opt.errorbells = false        -- No beep
opt.cursorline = true
opt.splitright = true
opt.splitbelow = true

-- Source other config files
cmd("source ~/.vim/key-mappings.vim")
cmd("source ~/.vim/color-theme.vim")
cmd("source ~/.vim/terminal.vim")
cmd("source ~/.vim/clang-format.vim")
cmd("source ~/.vim/nerdcommenter.vim")

-- Source other config files
require("thmxvr.treesitter")
require("thmxvr.lsp")
require("thmxvr.compe")
require("thmxvr.telescope")
require("thmxvr.lualine")

g['black#settings'] = {line_length= 79}

