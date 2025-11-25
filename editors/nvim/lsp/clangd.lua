return {
	name = "clangd",
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm"
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { 'compile_commands.json', 'compile_flags.txt' },
	on_attach = on_attach,
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = true,
		fallbackFlags = {
			"-Wall",
			"-Wextra",
			"-Wunused-parameter",
			"-Wunused-variable",
		},
	},
	capabilities = {
		textDocument = {
			publishDiagnostics = {
				tagSupport = {
					valueSet = { 1, 2 }
				}
			}
		}
	},
}
