return {
	-- Web devicons for better file icons
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				-- your personnal icons can go here (to override)
				-- you can specify color or cterm_color instead of specifying both of them
				-- DevIcon will be appended to `name`
				override = {
					zsh = {
						icon = "",
						color = "#428850",
						cterm_color = "65",
						name = "Zsh"
					}
				},
				-- globally enable different highlight colors per icon (default to true)
				color_icons = true,
				-- globally enable default icons (default to false)
				default = true,
			})
		end,
	},

	-- Smooth animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function()
			-- Don't use animate when scrolling with the mouse
			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			return {
				resize = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				scroll = {
					timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
				cursor = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				open = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				close = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
			}
		end,
	},
}