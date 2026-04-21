local M = {}

local _telescope = function ()
	vim.pack.add({
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" }
	})
	require( "telescope" ).setup()
	require( "telescope" ).load_extension( "fzf" )
end

local _oil = function ()
	vim.pack.add({
		{ src = "https://github.com/stevearc/oil.nvim" },
		{ src = "https://github.com/refractalize/oil-git-status.nvim" },
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" }
	})
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

M.setup = function ()
	_telescope()
	_oil()
end

return M
