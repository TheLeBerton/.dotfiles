local M = {}

M.setup = function ()
	require( "themery" ).setup({
		themes = vim.fn.getcompletion( "", "color" )
	})
end

return M
