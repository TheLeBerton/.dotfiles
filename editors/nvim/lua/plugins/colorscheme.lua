return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.wal").apply()
		end,
	},
	{ "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
	{ 'shaunsingh/nord.nvim', lazy = false, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{ 'Mofiqul/dracula.nvim', lazy = false, priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 }
}
