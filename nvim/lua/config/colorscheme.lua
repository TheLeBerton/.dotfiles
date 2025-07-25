local current = "rose-pine"

local function toggle_theme()
  if current == "rose-pine" then
    vim.cmd("colorscheme tokyonight")
	vim.cmd("set background=dark")
    current = "tokyonight"
  else
    vim.cmd("colorscheme rose-pine")
	vim.cmd("set background=light")
    current = "rose-pine"
  end
end

vim.api.nvim_create_user_command("ToggleTheme", toggle_theme, {})
