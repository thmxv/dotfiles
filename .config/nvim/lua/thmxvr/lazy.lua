local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Autocompletion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      -- { "hrsh7th/cmp-buffer" },
      -- { "hrsh7th/cmp-path" },
      -- { "saadparwaiz1/cmp_luasnip" },
      -- { "hrsh7th/cmp-nvim-lua" },
      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      }
      -- { "rafamadriz/friendly-snippets" },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- "jay-babu/mason-null-ls.nvim",
    -- "jay-babu/mason-nvim-dap.nvim",
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzy-native.nvim",
    build = "git submodule update --init --recursive",
  },
  "nvim-telescope/telescope-dap.nvim",
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  -- DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = { "nvim-neotest/nvim-nio" },
  },
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  --
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },
  "FabijanZulj/blame.nvim",
  "mbbill/undotree",
  "tpope/vim-sleuth",   -- Auto detect tabsize and other buffer settings
  "tpope/vim-dispatch", -- Async build/exec with result in quickfix list
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "matze/vim-move",       -- <Alt>h/j/k/l to move selection
  "nvie/vim-togglemouse", -- <F12> To use terminal mouse commands
  {
    "famiu/bufdelete.nvim",
    config = function()
      vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        shade_terminals = true,
      })
    end,
  },
  { -- Status line powerline style in lua
    "hoob3rt/lualine.nvim",
    -- config = function() require('lualine').setup() end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    -- Vertical lines in indentation
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        scope = { enabled = false },
      })
    end,
  },
  -- use {  -- Smooth scrolling
  --   "karb94/neoscroll.nvim",
  --   config = function() require("neoscroll").setup() end,
  -- }
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme("nightfox")
    end,
    dependencies = "indent-blankline.nvim",
  },
  "folke/trouble.nvim",
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({})
    end,
  },
})
