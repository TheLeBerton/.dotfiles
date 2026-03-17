local M = {}

function M.setup(capabilities)
	-- Type checker : autocomplétion, go-to-def, types
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

	-- Linter temps réel : souligne les erreurs de style, auto-fix via code actions
	vim.lsp.config("ruff", {
		cmd = { "ruff", "server" },
		filetypes = { "python" },
		root_markers = {
			"pyproject.toml",
			"ruff.toml",
			".git",
		},
		capabilities = capabilities,
	})
end

return M
