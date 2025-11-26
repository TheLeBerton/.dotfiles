local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
		{
			"nyoom-engineering/oxocarbon.nvim"
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("plugins.treesitter")
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.4",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("plugins.telescope")
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"zbirenbaum/copilot-cmp",
			},
			config = function()
				require("plugins.cmp")
			end
		},
		{
			"stevearc/oil.nvim",
			config = function()
				require("plugins.oil")
			end,
		},
		{
			"nvim-tree/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({
					default = true,
					strict = true,
					variant = "light", -- ou "dark"
					override_by_filename = {
						[".gitignore"] = {
							icon = "",
							color = "#f1502f",
							name = "Gitignore"
						}
					},
				})
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("plugins.gitsigns")
			end,
		},
		{
			"sphamba/smear-cursor.nvim",
			opts = {},
		},
		{
			'nvim-mini/mini.cursorword',
			version = false,
			config = function()
				require("mini.cursorword").setup()
			end
		},
		{
			'nvim-mini/mini.indentscope',
			version = false,
			config = function()
				require("mini.indentscope").setup()
			end
		},
		require("plugins.copilot"),
		{
		   "m4xshen/hardtime.nvim",
		   lazy = false,
		   dependencies = { "MunifTanjim/nui.nvim" },
		   opts = {},
		config = function()
			require("hardtime").setup()
		end
		},
		{
			"rcarriga/nvim-notify",
			config = function()
				vim.notify = require("notify")
				require("notify").setup({
					background_colour = "#000000",
				})
			end,
		},
	},
	{
		ui = {
			border = "rounded",
		},
		performance = {
			rtp = {
				disable_plugins = {
					"gzip",
					"matchit",
					"matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
	})
