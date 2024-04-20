vim.diagnostic.config({ virtual_text = false })

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  local opts = { buffer = bufnr }
  vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
  end, opts)
  -- Defaults mappings:
  -- K: Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
  -- gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
  -- gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. See :help vim.lsp.buf.declaration().
  -- gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
  -- go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
  -- gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
  -- gs: signature help
  -- <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
  -- x:
  -- <F4>: Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
  -- gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
  -- [d: Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
  -- ]d: Move to the next diagnostic. See :help vim.diagnostic.goto_next().
end)

-- Use system wide language servers to avoid version conflicts with toolchain
require("lspconfig").lua_ls.setup({})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = {"utf-16"}
require("lspconfig").clangd.setup({
  capabilities = capabilities
})
require("lspconfig").rust_analyzer.setup({
  cmd = { "rustup", "run", "stable", "rust-analyzer", },
  -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
})
-- require("lspconfig").jedi_language_server.setup({})
-- require("lspconfig").pylsp.setup({})
require("lspconfig").pyright.setup({})

-- see :help lsp-zero-guide:integrate-with-mason-nvim
-- to learn how to use mason.nvim with lsp-zero
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
  }
})

-- Change gutter diagnostic symbols
lsp_zero.set_sign_icons({
  error = "󰅚 ",
  warn = " ",
  info = "󰋽 ",
  hint = " ",
})

-- CMP
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
cmp.setup({
  mapping = cmp.mapping.preset.insert ({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  })
})

-- Null LS
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.diagnostics.cpplint,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.sqlfmt,
    -- null_ls.builtins.diagnostics.sqlfluff,
  },
})

require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      "diff",
      {
      	"diagnostics",
      	symbols = {
      	  error = "󰅚 ",
      	  warn = " ",
      	  info = "󰋽 ",
      	  hint = " ",
      	},
      },
    },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = { "toggleterm", "trouble", "quickfix" },
})

require("trouble").setup({
  icons = false,
  signs = {
    error = "󰅚",
    warning = "",
    hint = "",
    information = "󰋽",
    other = "󰗡",
  },
})

require("todo-comments").setup({
  keywords = {
    FIX = { icon = " " },
    TODO = { icon = " " },
    HACK = { icon = " " },
    WARN = { icon = " " },
    PERF = { icon = "󰔛 " },
    NOTE = { icon = "󱜾 " },
    TEST = { icon = " " },
  },
})

-- local ls = require("luasnip")
-- -- vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
-- -- vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i"}, "<Tab>", function() ls.expand_or_jump() end, {silent = true})
-- vim.keymap.set({"s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})
-- vim.keymap.set(
--   {"i", "s"}, "<C-E>",
--   function()
--     if ls.choice_active() then
--       ls.change_choice(1)
--     end
--   end, {silent = true}
-- )
