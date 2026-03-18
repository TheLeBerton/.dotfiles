return {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup({
			show_in_active_only = true,
			handle = {
				text = " ",
				color = "#FAF8F6",
				hide_if_all_visible = true,
			},
			marks = {
				Error = { text = " ", color = "#F7768E" },
				Warn = { text = " ", color = "#E0AF68" },
				Info = { text = " ", color = "#7DCFFF" },
				Hint = { text = " ", color = "#9ECE6A" },
			},
		})
	end,
}
