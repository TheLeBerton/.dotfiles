return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			columns = { "icon" },
			win_options = {
				signcolumn = "yes:2",
			},
			view_options = {
				show_hidden = false,
			},
			float = {
				padding = 2,
				max_width = 90,
				border = "rounded",
			},
			keymaps = {
				["q"] = "actions.close",
				["<C-c>"] = "actions.close",
			},
		})
	end,
	keys = {
		{ "-",         "<cmd>Oil --float<cr>", desc = "Open parent directory" },
		{ "<leader>-", "<cmd>Oil<cr>",         desc = "Open Oil float" },
	},
}
