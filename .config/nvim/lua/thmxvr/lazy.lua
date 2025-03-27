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
  -- LSP
  "neovim/nvim-lspconfig",
  -- Blink completion
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },
    -- use a release tag to download pre-built binaries
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      -- keymap = { preset = 'default' },
      keymap = { preset = 'enter' },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },
      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
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
    config = function()
      require("lualine").setup({
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            "diff",
            {
              "diagnostics",
              symbols = { error = "󰅚 ", warn = " ", info = "󰋽 ", hint = " ", },
            },
          },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "toggleterm", "trouble", "quickfix" },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  -- {
  --   "numToStr/Comment.nvim",
  --   config = function()
  --     require("Comment").setup()
  --   end,
  -- },
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
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    config = function()
      require("trouble").setup({
        -- icons = false,
        -- signs = {
        --   error = "󰅚",
        --   warning = "",
        --   hint = "",
        --   information = "󰋽",
        --   other = "󰗡",
        -- },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        keywords = {
          FIX = { icon = " " },
          TODO = { icon = " " },
          HACK = { icon = " " },
          WARN = { icon = " " },
          PERF = { icon = "󰔛 " },
          NOTE = { icon = "󱜾 " },
          TEST = { icon = " " },
        },
      })
    end,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({})
    end,
  },
  "DingDean/wgsl.vim",
  "projectfluent/fluent.vim",
})
