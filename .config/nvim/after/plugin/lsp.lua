-- No virtual text for diagnostics and custom signs
local x = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [x.ERROR] = "󰅚 ",
      [x.WARN] = " ",
      [x.HINT] = " ",
      [x.INFO] = "󰋽 "
    }
  }
})

-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  end,
})

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
require("lspconfig").lua_ls.setup({})
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { "utf-16" }
require("lspconfig").clangd.setup({
  -- capabilities = capabilities
})
require("lspconfig").rust_analyzer.setup({
  -- cmd = { "rustup", "run", "stable", "rust-analyzer", },
  -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  -- settings = {
  --   ["rust-analyzer"] = {
  --     cargo = {
  --       features = "all",
  --       -- TODO: use neoconf for project specific settings
  --       -- features = "ssr",
  --     },
  --   }
  -- }
})
-- require("lspconfig").jedi_language_server.setup({})
-- require("lspconfig").pylsp.setup({})
require("lspconfig").pyright.setup({})

