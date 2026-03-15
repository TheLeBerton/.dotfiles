local M = {}

function M.setup(capabilities)
	vim.lsp.config("basedpyright", {
		cmd = { "basedpyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = {
			"pyproject.toml",
			"setup.py",
			"requirements.txt",
			".git",
		},
		capabilities = capabilities,
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "basic",
					extraPaths = { "." },
				},
			},
		},
	})
end

return M
