return {
	{
		"sainnhe/everforest",
		priority = 1000,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd.colorscheme('rose-pine')
		end,
	},
	{
		'morhetz/gruvbox',
		name = "grubox"
	}
}
