return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			local keymap = vim.keymap.set

			-- Telescope keymaps
			keymap("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
			keymap("n", "<C-p>", builtin.git_files, { desc = "Find git files" })
			keymap("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Grep string" })
			keymap("n", "<leader>pw", builtin.grep_string, { desc = "Find word under cursor" })
			keymap("n", "<leader>vh", builtin.help_tags, { desc = "Help tags" })
		end,
	},
}