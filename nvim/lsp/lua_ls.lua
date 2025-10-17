return {
	cmd = { "/home/leberton/lua-language-server/bin/lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".stylua.toml"
	},
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostic = { globals = {"vim"} },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}
