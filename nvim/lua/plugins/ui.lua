local M = {}

-- color_schemes
local _color_schemes = function ()
	vim.pack.add({
		{ src = "https://github.com/olimorris/onedarkpro.nvim", name = "onedarkpro" },
		{ src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" },
		{ src = "https://github.com/rebelot/kanagawa.nvim", name="kanagawa" },
		{ src = "https://github.com/ellisonleao/gruvbox.nvim", name="gruvbox" },
		{ src = 'https://github.com/shaunsingh/nord.nvim', name="nord" },
		{ src = "https://github.com/folke/tokyonight.nvim", name="tokyonight" },
		{ src = 'https://github.com/Mofiqul/dracula.nvim', name="dracula" },
		{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	})
end

-- themery
local _themery = function ()
	vim.pack.add({
		{ src = "https://github.com/zaldih/themery.nvim" }
	})
	require( "themery" ).setup({
		themes = vim.fn.getcompletion( "", "color" )
	})
end

-- zen-mode
local _zen_mode = function ()
	vim.pack.add({
		{ src = "https://github.com/folke/zen-mode.nvim" }
	})
	require( "zen-mode" ).setup()
end

-- which-key
local _which_key = function()
	vim.pack.add({
		{ src = "https://github.com/folke/which-key.nvim" },
	})
	require( "which-key" ).setup()
end

M.setup = function ()
	_color_schemes()
	_themery()
	_zen_mode()
	_which_key()
end

return M
