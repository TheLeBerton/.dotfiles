local M = {}

function M.setup(capabilities)
	vim.lsp.config("lua_ls", {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = {
			".luarc.json",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			".git"
		},
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false
				},
				telemetry = { enable = false }
			}
		}
	})
end

return M
