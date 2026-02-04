local M = {}

function M.setup(capabilities)
	vim.lsp.config("sourcekit", {
		cmd = { "sourcekit-lsp" },
		filetypes = { "swift", "objective-c", "objective-cpp" },
		root_markers = {
			"buildServer.json",
			".xcodeproj",
			".xcworkspace",
			"Package.swift",
			".git"
		},
		capabilities = capabilities
	})
end

return M
