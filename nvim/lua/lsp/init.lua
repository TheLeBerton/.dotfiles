local M = {}

local servers = require( "lsp.servers" )

local init_mason = function()
	vim.pack.add({
		{ src = "https://github.com/mason-org/mason.nvim" },
	})
	require("mason").setup()
end

local start_servers = function()
	for name, config in pairs( servers ) do
		vim.lsp.config( name, config )
		vim.lsp.enable( name )
	end
end

M.setup = function()
	init_mason()
	start_servers()

	vim.api.nvim_create_autocmd('LspAttach', { callback = function( args )
		vim.lsp.inlay_hint.enable( true, { bufnr = args.buf } )
		vim.keymap.set( "n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { buffer = args.buf } )
		vim.keymap.set( "n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { buffer = args.buf } )
		vim.keymap.set( "n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", { buffer = args.buf } )
		vim.keymap.set( "n", "<leader>le", "<cmd>Telescope diagnostics<CR>", { buffer = args.buf } )
		vim.keymap.set( "n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { buffer = args.buf } )
		vim.keymap.set( "n", "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<CR>", { buffer = args.buf } )

	end } )
end

return M
