-- Mappings.
--- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { asinc = true }
  end, bufopts)
  vim.keymap.set('x', '<space>f', function()
    vim.lsp.buf.format { asinc = true }
  end, bufopts)
  -- illuminate
  require "illuminate".on_attach(client)
end

require("mason").setup()
require("mason-lspconfig").setup({
  -- ensure_installed = { "sumneko_lua", "pyright" }
})

-- default config for all servers
local function make_config()
  local config = {
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    -- enable snippet support
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    -- disable virtual text for diagnostics
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false }
      )
    },
  }
  return config
end

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
  -- Default handler
  function(server_name)
    lspconfig[server_name].setup(make_config())
  end,

  ["clangd"] = function()
    local config = make_config()
    config.capabilities.offsetEncoding = { 'utf8' }
    config.cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      -- '--query-driver=""',
    }
    lspconfig.clangd.setup(config);
  end,

  ["sumneko_lua"] = function()
    local luadev = require("lua-dev").setup({})
    local config = vim.tbl_extend("keep", make_config(), luadev)
    lspconfig.sumneko_lua.setup(config)
    -- config.settings = {
    --   Lua = {
    --     runtime = {
    --       -- LuaJIT in the case of Neovim
    --       version = 'LuaJIT',
    --       path = vim.split(package.path, ';'),
    --     },
    --     diagnostics = {
    --       -- Get the language server to recognize the `vim` global
    --       globals = {'vim'},
    --     },
    --     workspace = {
    --       -- Make the server aware of Neovim runtime files
    --       library = {
    --         [vim.fn.expand('$VIMRUNTIME/lua')] = true,
    --         [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
    --         [vim.fn.stdpath('config') .. '/lua'] = true,
    --       },
    --     },
    --   },
    -- }
    -- lspconfig.sumneko_lua.setup(config)
  end,
})

local nullls_diagconfig = {
  -- see :help vim.diagnostic.config()
  virtual_text = false,
}

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.completion.spell,

    require("null-ls").builtins.code_actions.refactoring,
    require("null-ls").builtins.code_actions.shellcheck,

    require("null-ls").builtins.diagnostics.shellcheck.with({
      diagnostic_config = nullls_diagconfig,
    }),
    -- require("null-ls").builtins.diagnostics.luacheck.with({
    --   diagnostic_config=nullls_diagconfig,
    -- }),
    -- require("null-ls").builtins.diagnostics.selene.with({
    --   diagnostic_config=nullls_diagconfig,
    -- }),

    require("null-ls").builtins.formatting.prettier,
    require("null-ls").builtins.formatting.shfmt,
    require("null-ls").builtins.formatting.stylua,
  },
})


-- Change gutter diagnostic symbols
local signs = { Error = " ", Warn = " ", Info = " ", Hint = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- LSP Saga
-- require('lspsaga').init_lsp_saga()
