return {
	"RRethy/vim-illuminate",
	event = "BufReadPost",
	config = function()
		require("illuminate").configure({
			delay = 200,
			filetypes_denylist = {
				"oil",
				"TelescopePrompt",
			},
		})
	end,
}
