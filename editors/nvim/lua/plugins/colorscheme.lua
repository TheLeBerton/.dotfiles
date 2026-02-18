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
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none", fg = theme.ui.nontext },
					FloatTitle  = { bg = "none" },
					TelescopeBorder       = { fg = theme.ui.nontext, bg = "none" },
					TelescopeNormal       = { bg = "none" },
					TelescopePromptNormal = { bg = "none" },
					TelescopeResultsNormal = { bg = "none" },
					TelescopePreviewNormal = { bg = "none" },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
