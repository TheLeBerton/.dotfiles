local M = {}

local current = "tokyonight"

function M.toggle()
	if current == "rose-pine" then
    	vim.cmd("colorscheme tokyonight")
		vim.cmd("set background=dark")
    	current = "tokyonight"
		vim.notify("Switched to TokyoNight", vim.log.levels.INFO)
	elseif current == "falcon" then
    	vim.cmd("colorscheme rose-pine")
		vim.cmd("set background=light")
    	current = "rose-pine"
		vim.notify("Switched to Rose-Pine", vim.log.levels.INFO)
	else
    	vim.cmd("colorscheme falcon")
		vim.cmd("set background=dark")
    	current = "falcon"
		vim.notify("Switched to Falcon", vim.log.levels.INFO)

  end
end

vim.api.nvim_create_user_command("ToggleTheme", M.toggle, {})

return M
