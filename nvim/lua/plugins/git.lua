local M = {}

local _gitsigns = function ()
	vim.pack.add({
		{ src = "https://github.com/lewis6991/gitsigns.nvim" }
	})
	require( "gitsigns" ).setup()
end

M.setup = function ()
	_gitsigns()
end

return M
