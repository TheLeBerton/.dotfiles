local M = {}


M.servers = {
	["lua_ls"] = { cmd = { "lua-language-server" }, filetypes = { "lua" }, settings = { Lua = {
		diagnostics = { globals = { "vim" } }, workspace = { library = vim.api.nvim_get_runtime_file( "", true ) }
	} } },
	["pyright"] = { cmd = { "pyright-langserver", "--stdio" }, filetypes = { "python" }, root_markers = { "pyrightconfig.json", ".git" }, settings = { python = { analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true, diagnosticMode = "workspace" } } } },
	["clangd"] = { cmd = { "clangd" }, filetypes = { "c", "cpp" } }
}


local init_mason = function()
	vim.pack.add({
		{ src = "https://github.com/mason-org/mason.nvim" },
	})
	require("mason").setup()
end


local start_servers = function()
	for name, config in pairs( M.servers ) do
		vim.lsp.config( name, config )
		vim.lsp.enable( name )
	end
end

M.setup = function()
	init_mason()
	start_servers()
end


return M
