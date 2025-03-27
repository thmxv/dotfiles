local telescope = require('telescope')

telescope.setup({
  defaults = {
    file_ignore_patterns = { "^venv/" }
  }
})
telescope.load_extension('fzy_native')
telescope.load_extension('dap')

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>')
vim.keymap.set('n', '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
vim.keymap.set('n', '<leader>f*', '<cmd>Telescope grep_string<cr>')
