local M = {}

M.setup = function()
	require( "core.options" ).setup()
	require( "core.keymaps" ).setup()
end

M.after = function()
	require( "core.theme" ).setup()
end

return M
