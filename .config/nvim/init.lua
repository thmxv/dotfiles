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
    -- My installed plugins
    "nvim-lua/plenary.nvim";
    "neovim/nvim-lspconfig";
    "kabouzeid/nvim-lspinstall";
    "ray-x/lsp_signature.nvim";
    "glepnir/lspsaga.nvim";
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-nvim-lua";
    "hrsh7th/cmp-nvim-lsp";
    {"nvim-treesitter/nvim-treesitter", run = function() cmd('TSUpdate') end};
    "nvim-telescope/telescope.nvim";
    "nvim-telescope/telescope-fzy-native.nvim";
    "tpope/vim-sensible";
    "tpope/vim-sleuth";
    "tpope/vim-surround";
    "tpope/vim-repeat";
    "tpope/vim-fugitive";
    "lewis6991/gitsigns.nvim";
    "preservim/nerdcommenter";
    "raimondi/delimitmate";
    "ishan9299/nvim-solarized-lua";
    "hoob3rt/lualine.nvim";
    {"a-vrma/black-nvim", run = function() cmd('UpdateRemotePlugins') end};
    "akinsho/toggleterm.nvim";
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
-- TODO: switch those to lua and move from $HOME/.vim/ directory
-- to $HOME/.config/nvim/lua/thmxvr
cmd("source ~/.vim/key-mappings.vim")
cmd("source ~/.vim/color-theme.vim")
cmd("source ~/.vim/terminal.vim")
cmd("source ~/.vim/clang-format.vim")
cmd("source ~/.vim/nerdcommenter.vim")

-- Source other config files
require("thmxvr.treesitter")
require("thmxvr.lsp")
require("thmxvr.completion")
require("thmxvr.telescope")
require("thmxvr.lualine")

g['black#settings'] = {
  line_length = 79
}

require('gitsigns').setup()

-- TODO: Move to teminal file with key-mappings
require("toggleterm").setup{
  open_mapping = [[<c-\>]],
}
