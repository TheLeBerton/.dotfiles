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
		vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "WinClosed" }, {
			callback = function()
				vim.schedule(function()
					local wins = vim.tbl_filter(function(w)
						return vim.api.nvim_win_get_config(w).relative == ""
					end, vim.api.nvim_list_wins())
					local zen = require("zen-mode.view")
					if #wins == 1 and not zen.is_open() then
						require("zen-mode").open()
					elseif #wins > 1 and zen.is_open() then
						require("zen-mode").close()
					end
				end)
			end,
		})
	end
}
