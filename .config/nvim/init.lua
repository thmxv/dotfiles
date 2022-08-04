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
    "williamboman/mason-lspconfig.nvim";
    "mfussenegger/nvim-dap";
    "jose-elias-alvarez/null-ls.nvim";
    "williamboman/mason.nvim";
    "ray-x/lsp_signature.nvim";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-nvim-lua";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-path";
    "hrsh7th/cmp-cmdline";
    "hrsh7th/nvim-cmp";
    'L3MON4D3/LuaSnip';
    'saadparwaiz1/cmp_luasnip';
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
    "akinsho/toggleterm.nvim";
    "famiu/bufdelete.nvim";
    -- "glepnir/lspsaga.nvim";
    -- "chipsenkbeil/distant.nvim";
    -- "phaazon/hop.nvim";
    -- "kevinhwang91/promise-async";
    -- "kevinhwang91/nvim-ufo";
    -- "folke/trouble.nvim";
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

g.netrw_liststyle = 3
g.netrw_banner = 0
-- g.delimitMate_expand_cr = 1

cmd("filetype indent plugin on")
cmd("set termguicolors")   -- Use true colors
cmd("set background=dark") -- BEFORE colorscheme
cmd("colorscheme solarized")

local opts = { remap=false , silent=true }

-- Quick open/reload settings
vim.keymap.set('n', '<leader>ev', '<cmd>e $MYVIMRC<cr>', opts)
vim.keymap.set('n', '<leader>sv', 
  '<cmd>source $MYVIMRC <bar> doautocmd BufRead<cr>', opts
)

-- Clear search higlight on ESC
vim.keymap.set('n', '<esc>', '<cmd>noh<cr><esc>', opts)

-- " Buffer delete without closing split
vim.keymap.set('n', '<leader>bd', '<cmd>Bdelete<CR>', opts)

-- " Telescope
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', opts)

-- Termial helper
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
-- vim.keymap.set('t', '<M-[>', '<Esc>', opts)
-- vim.keymap.set('t', '<C-v><Esc>', '<Esc>', opts)

-- Window navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)
vim.keymap.set('i', '<C-h>', '<Esc><C-w>h', opts)
vim.keymap.set('i', '<C-j>', '<Esc><C-w>j', opts)
vim.keymap.set('i', '<C-k>', '<Esc><C-w>k', opts)
vim.keymap.set('i', '<C-l>', '<Esc><C-w>l', opts)
vim.keymap.set('v', '<C-h>', '<Esc><C-w>h', opts)
vim.keymap.set('v', '<C-j>', '<Esc><C-w>j', opts)
vim.keymap.set('v', '<C-k>', '<Esc><C-w>k', opts)
vim.keymap.set('v', '<C-l>', '<Esc><C-w>l', opts)
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)


-- " Add spaces after comment delimiters by default
-- let g:NERDSpaceDelims = 1
-- " Use compact syntax for prettified multi-line comments
-- let g:NERDCompactSexyComs = 1
-- " Align line-wise comment delimiters flush left instead of following code indentation
-- let g:NERDDefaultAlign = 'left'
-- " Allow commenting and inverting empty lines (useful when commenting a region)
-- let g:NERDCommentEmptyLines = 1
-- " Enable trimming of trailing whitespace when uncommenting
-- let g:NERDTrimTrailingWhitespace = 1
-- " Enable NERDCommenterToggle to check all selected lines is commented or not
-- let g:NERDToggleCheckAllLines = 1


-- Source other config files
require("thmxvr.treesitter")
require("thmxvr.completion")
require("thmxvr.lsp")
require("thmxvr.telescope")
require("thmxvr.lualine")

require('gitsigns').setup()

require("toggleterm").setup{
  open_mapping = [[<c-\>]],
}

vim.api.nvim_command('autocmd BufNewFile,BufRead *.mxx set ft=cpp')

--require('distant').setup {
  ---- Applies Chip's personal settings to every machine you connect to
  ----
  ---- 1. Ensures that distant servers terminate with no connections
  ---- 2. Provides navigation bindings for remote directories
  ---- 3. Provides keybinding to jump into a remote file's parent directory
  --['*'] = require('distant.settings').chip_default()
--}

