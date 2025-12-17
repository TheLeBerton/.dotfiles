return
{
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = "🔍 ",
				selection_caret = "➜ ",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						preview_width = 0.6,
					},
				},
				file_ignore_patterns = {
					"node_modules/",
					".git/",
					"*.o",
					"*.a",
				},
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
						["<ESC>"] = "close",
					}
				},
			}
		})
	end,
	keys = {
		{ "<C-f>",      "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<C-g>",      "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
	},
}
