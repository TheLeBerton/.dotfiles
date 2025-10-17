return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- configure lualine with auto theme detection
		local function get_theme()
			local colorscheme = vim.g.colors_name
			if colorscheme == "tokyonight" then
				return "tokyonight"
			elseif colorscheme == "catppuccin" then
				return "catppuccin"
			else
				return "auto"
			end
		end

		lualine.setup({
			options = {
				theme = get_theme(),
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree", "trouble" },
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 1, -- 0: Just the filename
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = " ",
							newfile = " ",
						},
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{
						"encoding",
						fmt = string.upper,
					},
					{
						"fileformat",
						symbols = {
							unix = "",
							dos = "",
							mac = "",
						},
					},
					"filetype",
				},
				lualine_y = {
					{
						"progress",
					},
				},
				lualine_z = {
					{
						"location",
						icon = "",
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive", "oil", "quickfix" },
		})
	end,
}