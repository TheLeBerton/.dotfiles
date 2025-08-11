local M = {}

local themes = {
	{ name = "tokyonight", background = "dark" },
	{ name = "rose-pine", background = "light" },
	{ name = "falcon", background = "dark" },
	{ name = "catppuccin", background = "light" },
	{ name = "onedark", background = "dark" },
	{ name = "kanagawa", background = "dark" },
	{ name = "nightfox", background = "dark" },
	{ name = "melange", background = "dark" },
}

local current_idx = 1

local function apply_theme(idx)
	local theme = themes[idx]
	vim.cmd("colorscheme " .. theme.name)
	vim.o.background = theme.background
	vim.notify("Switched to " .. theme.name, vim.log.levels.INFO)
end

function M.toggle()
	current_idx = (current_idx % #themes) + 1
	apply_theme(current_idx)
end

apply_theme(current_idx)

vim.api.nvim_create_user_command("ToggleTheme", M.toggle, {})

return M
