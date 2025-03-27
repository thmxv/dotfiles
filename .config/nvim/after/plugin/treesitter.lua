require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "lua", "rust", "python", "cmake", "bash", "cpp",
    "devicetree", "glsl", "go", "json", "make", "teal", "toml", "vim"
  },
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_previous_start = {
        ["[b"] = "@block.outer",
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_next_end = {
        ["]b"] = "@block.outer",
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[B"] = "@block.outer",
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
      },
      goto_next_start = {
        ["]B"] = "@block.outer",
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
      },
    },
  },
}

require("treesitter-context").setup({
  max_lines = 6,
  multiline_threshold = 1,
  trim_scope = "inner",
  patterns = {
    default = {
      'class',
      'struct',
      'function',
      'method',
      'for',
      'while',
      'if',
      'switch',
      'case',
    }
  }
})

