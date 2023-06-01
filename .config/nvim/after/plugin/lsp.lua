require("neodev").setup({})

local lsp_zero = require("lsp-zero").preset({
	name = "minimal",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = false,
})

-- List of servers to intall with Mason without asking
-- lsp_zero.ensure_installed({'<server>', })

-- Use system wide language servers to avoid version conflicts with toolchain
lsp_zero.configure("lua_ls", { force_setup = true })
lsp_zero.configure("clangd", { force_setup = true })
lsp_zero.configure("pyright", { force_setup = true })
lsp_zero.configure("rust_analyzer", {
	force_setup = true,
	-- cmd = { "rustup", "run", "stable", "rust-analyzer", },
	cmd = { "rustup", "run", "nightly", "rust-analyzer" },
})

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr }
	local bind = vim.keymap.set
	-- Reformat buffer or range
	bind("n", "<leader>f", "<cmd>LspZeroFormat<CR>", opts)
	-- Defaults mappings:
	-- K: Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
	-- gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
	-- gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. See :help vim.lsp.buf.declaration().
	-- gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
	-- go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
	-- gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
	-- <Ctl-k>: Displays signature information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.signature_help(). If a mapping already exists for this key this function is not bound.
	-- <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
	-- <F4>: Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
	-- gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
	-- [d: Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
	-- ]d: Move to the next diagnostic. See :help vim.diagnostic.goto_next().
end)

-- Don't preselect first match
lsp_zero.setup_nvim_cmp({
	preselect = require("cmp").PreselectMode.None,
	completion = {
		completeopt = "menu,menuone,noinsert,noselect",
	},
})

-- Configure Lua language server for neovim
lsp_zero.nvim_workspace()

-- Needs to be after all the lsp_zero configuration
lsp_zero.setup()

-- Null LS
local null_ls = require("null-ls")
local null_opts = lsp_zero.build_options("null-ls", {})
null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
	end,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.diagnostics.cpplint,
		null_ls.builtins.formatting.stylua,
	},
})

-- Change gutter diagnostic symbols
local signs = { Error = "󰅚 ", Warn = " ", Info = "󰋽 ", Hint = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

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
