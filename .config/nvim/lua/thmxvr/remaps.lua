-- vim.g.mapleader = " "

-- Quick open/reload settings
vim.keymap.set('n', '<leader>ev', '<cmd>e $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>sv',
    '<cmd>source $MYVIMRC <bar> doautocmd BufRead<cr>'
)

-- Clear search higlight on ESC
vim.keymap.set('n', '<esc>', '<cmd>noh<cr><esc>')

-- Center after pgup/pgdwn
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Termial helper
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
-- vim.keymap.set('t', '<M-[>', '<Esc>')
-- vim.keymap.set('t', '<C-v><Esc>', '<Esc>')

-- Window navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set('i', '<C-h>', '<Esc><C-w>h')
vim.keymap.set('i', '<C-j>', '<Esc><C-w>j')
vim.keymap.set('i', '<C-k>', '<Esc><C-w>k')
vim.keymap.set('i', '<C-l>', '<Esc><C-w>l')
vim.keymap.set('v', '<C-h>', '<Esc><C-w>h')
vim.keymap.set('v', '<C-j>', '<Esc><C-w>j')
vim.keymap.set('v', '<C-k>', '<Esc><C-w>k')
vim.keymap.set('v', '<C-l>', '<Esc><C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
