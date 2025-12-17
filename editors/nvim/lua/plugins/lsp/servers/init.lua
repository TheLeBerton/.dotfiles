local M = {}

function M.setup()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	require("plugins.lsp.servers.lua").setup(capabilities)
	require("plugins.lsp.servers.clangd").setup(capabilities)
	require("plugins.lsp.servers.python").setup(capabilities)
	require("plugins.lsp.servers.bash").setup(capabilities)
	require("plugins.lsp.servers.swift").setup(capabilities)
	vim.lsp.enable({
		"lua_ls",
		"clangd",
		"pyright",
		"bashls",
		"sourcekit",
	})
end

return M
