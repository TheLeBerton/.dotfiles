return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				-- "clangd",
				"pyright",
				"bashls",
			},
			automatic_installation = true,
		})
		require("plugins.lsp.diagnostics").setup()
		require("plugins.lsp.keymaps").setup()
		require("plugins.lsp.servers").setup()
	end
}
