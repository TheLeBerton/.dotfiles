return {
	-- Git integration
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Surround
	{
		"tpope/vim-surround",
	},

	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Better quickfix
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},
}