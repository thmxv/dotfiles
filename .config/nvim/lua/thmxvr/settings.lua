vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.o.showmode = false
vim.opt.listchars = {
  tab = "→\\",
  trail = "·",
  precedes = "«",
  extends = "»",
  eol = "⏎",
}
-- vim.opt.list = true              -- Display above hidden control char
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mousescroll = "ver:1"

vim.cmd.filetype("indent plugin on")

-- C++ config for file extension and comment string
vim.api.nvim_command("autocmd BufNewFile,BufRead *.mxx set ft=cpp")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.api.nvim_set_option_value("commentstring", "// %s", { buf = 0 })
  end,
})

-- Rust comment string
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rs",
  callback = function()
    vim.api.nvim_set_option_value("commentstring", "// %s", { buf = 0 })
  end,
})

-- wgsl comment string
vim.api.nvim_create_autocmd("FileType", {
  pattern = "wgsl",
  callback = function()
    vim.api.nvim_set_option_value("commentstring", "// %s", { buf = 0 })
  end,
})

-- vim.filetype.add { extension = { wgsl = "wgsl" } }
-- vim.api.nvim_command('autocmd BufNewFile,BufRead *.wgsl set ft=wgsl')

-- Neovide specifics
if vim.g.neovide == true then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
end
