require("telescope").setup({
	defaults = {
		prompt_prefix = ":: ",
		selection_caret = "> ",
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
			"*.so",
		},
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
				["<C-q>"] = "send_selected_to_qflist",
				["<ESC>"] = "close",
			},
		},
	},
	pickers = {
		find_files = {
			hidden = false,
			follow = true,
		},
		live_grep = {
			additional_args = function()
				return {"--hidden"}
			end
		},
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
		},
	},
})
