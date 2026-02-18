return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local c = {
			bg      = "#0a0b0e",
			surface = "#161820",
			accent  = "#3d4566",
			fg      = "#c2cae0",
			fg_dim  = "#565e78",
		}

		local theme = {
			normal = {
				a = { fg = c.fg,     bg = c.surface },
				b = { fg = c.fg_dim, bg = c.bg },
				c = { fg = c.fg_dim, bg = c.bg },
			},
			insert = {
				a = { fg = c.fg,     bg = c.accent },
				b = { fg = c.fg_dim, bg = c.bg },
				c = { fg = c.fg_dim, bg = c.bg },
			},
			visual = {
				a = { fg = c.fg,     bg = c.surface },
				b = { fg = c.fg_dim, bg = c.bg },
				c = { fg = c.fg_dim, bg = c.bg },
			},
			replace = {
				a = { fg = c.fg,     bg = c.surface },
				b = { fg = c.fg_dim, bg = c.bg },
				c = { fg = c.fg_dim, bg = c.bg },
			},
			command = {
				a = { fg = c.fg,     bg = c.surface },
				b = { fg = c.fg_dim, bg = c.bg },
				c = { fg = c.fg_dim, bg = c.bg },
			},
			inactive = {
				a = { fg = c.fg_dim, bg = c.bg },
				b = { fg = c.fg_dim, bg = c.bg },
				c = { fg = c.fg_dim, bg = c.bg },
			},
		}

		require("lualine").setup({
			options = {
				theme = theme,
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "diagnostics" },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
