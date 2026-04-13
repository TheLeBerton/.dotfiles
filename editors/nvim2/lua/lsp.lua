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
	for name, _ in pairs( M.servers ) do
		vim.lsp.config( name, M.servers[name] )
		vim.lsp.enable( name )
	end
end

local function init_loved2d()
	vim.pack.add({
		{ src = "https://github.com/S1M0N38/love2d.nvim" }
	})
	require( "love2d" ).setup()
end


M.setup = function()
	init_mason()
	start_servers()
	init_loved2d()
end


return M
