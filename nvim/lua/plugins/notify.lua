return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")

		-- Configure nvim-notify
		notify.setup({
			background_colour = "NotifyBackground",
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
			render = "compact",
			stages = "fade_in_slide_out",
			timeout = 5000,
			top_down = true
		})

		-- Set nvim-notify as the default notify function
		vim.notify = notify
	end,
}