return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPost",
	opts = {
		"*",
		css = { rgb_fn = true },
		html = { names = false },
	},
}
