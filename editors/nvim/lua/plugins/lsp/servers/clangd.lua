local M = {}

function M.setup(capabilities)
	vim.lsp.config("clangd", {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
			"--function-arg-placeholders=true",
		},
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_markers = {
			"compile_commands.json",
			"compile_flags.txt",
			".git"
		},
		capabilities = capabilities
	})
end

return M
