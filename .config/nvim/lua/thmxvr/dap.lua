
local opts = { remap=false , silent=true }

vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, opts)
vim.keymap.set('n', '<leader>dc', require('dap').continue, opts)
vim.keymap.set('n', '<leader>dn', require('dap').step_over, opts)
vim.keymap.set('n', '<leader>ds', require('dap').step_into, opts)
vim.keymap.set('n', '<leader>dt', require('dap').terminate, opts)
vim.keymap.set('n', '<leader>dr', require('dap').repl.open, opts)
vim.keymap.set('n', '<leader>dd', require('dapui').toggle, opts)

local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = '/usr/bin/codelldb',
    args = {"--port", "${port}"},
  }
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input(
        'Path to executable: ',
        vim.fn.getcwd() .. '/',
        'file'
      )
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require('nvim-dap-virtual-text').setup()
require('dapui').setup()

