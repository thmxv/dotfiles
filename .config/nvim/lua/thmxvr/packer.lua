return require("packer").startup(
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- LSP
    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lua' },
        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
      },
    }
    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      requires = { { 'nvim-lua/plenary.nvim' } },
    }
    use {
      'nvim-telescope/telescope-fzy-native.nvim',
      run = 'git submodule update --init --recursive'
    }
    use 'nvim-telescope/telescope-dap.nvim'
    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    -- DAP
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    --
    use 'mbbill/undotree' -- TODO: Configure keymap to toggle
    use 'tpope/vim-fugitive' -- Git
    use "tpope/vim-sleuth" -- Auto detect tabsize and other buffer settings
    use 'tpope/vim-dispatch' -- Async build/exec with result in quickfix list
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "matze/vim-move" -- <Alt>h/j/k/l to move selection
    use "nvie/vim-togglemouse" -- <F12> To use terminal mouse commands
    use {
      'famiu/bufdelete.nvim',
      config = function()
        vim.keymap.set('n', '<leader>bd', '<cmd>Bdelete<CR>')
      end,
    }
    use {
      'akinsho/toggleterm.nvim',
      config = function()
        require("toggleterm").setup({
          open_mapping = [[<c-\>]],
          shade_terminals = true,
        })
      end,
    }
    use { -- Status line powerline style in lua
      'hoob3rt/lualine.nvim',
      config = function() require('lualine').setup() end,
    }
    use {
      'lewis6991/gitsigns.nvim',
      config = function() require('gitsigns').setup() end,
    }
    use {
      'numToStr/Comment.nvim',
      config = function() require('Comment').setup() end,
    }
    use { -- Vertical lines in indentation
      'lukas-reineke/indent-blankline.nvim',
      config = function() require("indent_blankline").setup() end,
    }
    -- use {  -- Smooth scrolling
    --   "karb94/neoscroll.nvim",
    --   config = function() require("neoscroll").setup() end,
    -- }
    use { -- Colorscheme
      'EdenEast/nightfox.nvim',
      config = function() vim.cmd.colorscheme("nightfox") end,
      after = "indent-blankline.nvim",
    }
  end
)
