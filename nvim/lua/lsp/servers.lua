return {
	["lua_ls"] = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = vim.api.nvim_get_runtime_file( "", true )
				},
				completion = { callSnippet = "Replace" },
				hint = { enable = true }
			}
		}
	},
	["pyright"] = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = { "pyrightconfig.json", ".git" },
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace"
				}
			}
		}
	},
	["clangd"] = {
		cmd = { "clangd" },
		filetypes = { "c", "cpp" }
	}
}
