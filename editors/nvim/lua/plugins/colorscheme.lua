return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			transparent = true,
			dimInactive = true,
		})
		vim.cmd.colorscheme("kanagawa-wave")
	end,
}
