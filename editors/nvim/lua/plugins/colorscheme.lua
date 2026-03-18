return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			transparent = true,
			dimInactive = true,
			overrides = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = theme.ui.bg },
					FloatBorder = { bg = theme.ui.bg, fg = theme.ui.nontext },
					FloatTitle  = { bg = theme.ui.bg },
					TelescopeBorder       = { fg = theme.ui.nontext, bg = "none" },
					TelescopeNormal       = { bg = "none" },
					TelescopePromptNormal = { bg = "none" },
					TelescopeResultsNormal = { bg = "none" },
					TelescopePreviewNormal = { bg = "none" },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa-wave")
	end,
}
