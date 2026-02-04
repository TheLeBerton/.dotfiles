local M = {}

function M.setup(capabilities)
	vim.lsp.config("bashls", {
		cmd = { "bash-language-server", "start" },
		filetypes = { "sh", "bash" },
		root_markers = { ".git" },
		capabilities = capabilities,
	})
end

return M
