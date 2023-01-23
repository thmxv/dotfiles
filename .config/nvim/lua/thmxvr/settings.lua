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
  tab='→\\',
  trail='·',
  precedes='«',
  extends='»',
  eol='⏎',
}
-- vim.opt.list = true              -- Display above hidden control char
-- vim.opt.showmatch = true            -- Show matching parenthesis
-- vim.opt.mouse = 'a'
-- 
-- vim.opt.hidden = true               -- Allow openning/switch buffer when current buffer is edited
-- --vim.opt.ignorecase = true         -- Ignore case for search
-- vim.opt.history = 50                -- Commands in search history
-- vim.opt.undolevels = 1000           -- Levels of undo
-- vim.opt.title = true                -- Change terminal's title
-- vim.opt.visualbell = true           -- No beep
-- --vim.opt.errorbells = false        -- No beep
-- vim.opt.cursorline = true
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true
-- 
-- g.netrw_liststyle = 3
-- g.netrw_banner = 0

vim.cmd.filetype("indent plugin on")

-- C++ config for file extension and comment string
vim.api.nvim_command('autocmd BufNewFile,BufRead *.mxx set ft=cpp')
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  end
})

-- Neovide specifics
if vim.g.neovide == true then
  vim.o.guifont = 'JetBrainsMono Nerd Font:h14'
--   vim.keymap.set(
--     'n',
--     '<F11>',
--     ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>",
--     {}
--   )
end
