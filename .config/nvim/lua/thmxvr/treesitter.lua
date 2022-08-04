
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "rust", "python", "cmake", "bash", "cpp", "devicetree", "glsl", "go", "json", "make", "teal", "toml", "vim" },
  highlight = {
    enable = true,
  }
}

