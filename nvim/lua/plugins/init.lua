local M = {}

M.setup = function ()
	require( "plugins.pack" ).setup()
	require( "plugins.treesitter" ).setup()
	require( "plugins.themery" ).setup()
	require( "plugins.oil" ).setup()
	require( "plugins.telescope" ).setup()
	require( "plugins.gitsigns" ).setup()
	require( "plugins.blink" ).setup()
	require( "plugins.zen-mode" ).setup()
	require( "plugins.which-key" ).setup()
end



return M
