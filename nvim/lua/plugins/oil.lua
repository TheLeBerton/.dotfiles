local M = {}

M.setup = function ()
	require( "oil" ).setup({
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
		},
		win_options = {
			signcolumn = "yes:2"
		},
		keymaps = {
			["q"] = "actions.close",
			["<C-c>"] = "actions.close",
		},
	})
	require( "oil-git-status" ).setup({})
end

return M
