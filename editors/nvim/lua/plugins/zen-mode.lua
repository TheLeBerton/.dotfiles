return {
	"folke/zen-mode.nvim",
	opts = {
		backdrop = 0,
		window = {
			options = {
				number = false,
				relativenumber = false,
			}
		}
	},
	config = function(_, opts)
		require("zen-mode").setup(opts)
	end
}
