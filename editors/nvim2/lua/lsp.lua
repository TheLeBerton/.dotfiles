local M = {}


M.servers = {
	["lua_ls"] = { cmd = { "lua-language-server" }, filetypes = { "lua" }, settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
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


local setup_completion = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true } )
			end
		end
	})
end


M.setup = function()
	init_mason()
	start_servers()
	setup_completion()
end


return M
