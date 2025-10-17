return {
	-- Primary theme: TokyoNight (NvChad-like)
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night", -- storm, moon, night, day
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true, bold = true },
					functions = { bold = true },
					variables = {},
					sidebars = "dark",
					floats = "dark",
				},
				sidebars = { "qf", "help", "neo-tree", "terminal" },
				day_brightness = 0.3,
				hide_inactive_statusline = false,
				dim_inactive = false,
				lualine_bold = true,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- Alternative: Catppuccin Mocha
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					keywords = { "bold" },
					functions = { "bold" },
					strings = {},
					variables = {},
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					notify = true,
					telescope = { enabled = true },
					harpoon = true,
					lsp_trouble = true,
					which_key = true,
					mason = true,
					indent_blankline = {
						enabled = true,
						scope_color = "sapphire",
						colored_indent_levels = false,
					},
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
				},
			})
			-- Uncomment to switch to catppuccin:
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
}