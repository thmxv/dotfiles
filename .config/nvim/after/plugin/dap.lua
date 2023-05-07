vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<leader>dc", require("dap").continue)
vim.keymap.set("n", "<leader>dn", require("dap").step_over)
vim.keymap.set("n", "<leader>ds", require("dap").step_into)
vim.keymap.set("n", "<leader>dt", require("dap").terminate)
vim.keymap.set("n", "<leader>dr", require("dap").repl.toggle)
vim.keymap.set("n", "<leader>dd", require("dapui").toggle)

-- -- Change gutter diagnostic symbols
local signs = {
  Breakpoint = " ",
  BreakpointCondition = " ",
  LogPoint = " ",
  Stopped = " ",
  BreakpointRejected = " ",
}
for type, icon in pairs(signs) do
  local hl = "Dap" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

local dap = require("dap")
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "/usr/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

local last_cmd = vim.fn.getcwd() .. "/"
local last_args = ""
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      last_cmd = vim.fn.input("Path to executable: ", last_cmd, "file")
      return last_cmd
    end,
    args = function()
      local args = vim.fn.input("Arguments: ", last_args, "file")
      last_args = args
      local result = vim.split(args, " ", {})
      for k, v in pairs(result) do
        if v == "" then
          result[k] = nil
        end
      end
      return result
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("nvim-dap-virtual-text").setup({})

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.close({})
end
