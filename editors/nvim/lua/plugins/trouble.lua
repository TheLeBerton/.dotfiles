return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
		{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
	},
	opts = {},
}
