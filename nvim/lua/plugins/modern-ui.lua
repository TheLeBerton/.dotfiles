return {
	-- Better notifications
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				fps = 30,
				icons = {
					DEBUG = "",
					ERROR = "",
					INFO = "",
					TRACE = "✎",
					WARN = ""
				},
				level = 2,
				minimum_width = 50,
				render = "default",
				stages = "fade_in_slide_out",
				timeout = 3000,
				top_down = true
			})
			vim.notify = require("notify")
		end,
	},

	-- Modern which-key (if you want command hints)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			require("which-key").setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = {
						enabled = true,
						suggestions = 20,
					},
					presets = {
						operators = false,
						motions = false,
						text_objects = false,
						windows = true,
						nav = true,
						z = true,
						g = true,
					},
				},
				window = {
					border = "rounded",
					position = "bottom",
					margin = { 1, 0, 1, 0 },
					padding = { 1, 2, 1, 2 },
					winblend = 0,
				},
				layout = {
					height = { min = 4, max = 25 },
					width = { min = 20, max = 50 },
					spacing = 3,
					align = "left",
				},
				ignore_missing = true,
				hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
				show_help = true,
				triggers = "auto",
				triggers_blacklist = {
					i = { "j", "k" },
					v = { "j", "k" },
				},
			})
		end,
	},

	-- Better diagnostics icons
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			icons = true,
			fold_open = "",
			fold_closed = "",
			indent_lines = true,
			signs = {
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "",
			},
			use_diagnostic_signs = true
		},
	},
}