return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
	require("telescope").setup {
	    pickers = {
		find_files = {
		    theme = "ivy",
		},
		live_grep = {
		    theme = "ivy",
		},
		grep_string = {
		    theme = "ivy",
		},
	    }
	}
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope [F]ind [F]iles" })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope [F]ind [G]rep" })
	vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Telescope [F]ind [W]ord" })
    end
}
