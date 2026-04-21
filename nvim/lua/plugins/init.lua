local M = {}

M.setup = function ()
	require( "plugins.ui" ).setup()
	require( "plugins.editor" ).setup()
	require( "plugins.git" ).setup()
	require( "plugins.navigation" ).setup()
end



return M
