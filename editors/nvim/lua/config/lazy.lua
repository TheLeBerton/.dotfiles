-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	require("plugins.colorscheme"),
	require("plugins.mason"),
	require("plugins.lsp"),
	require("plugins.telescope"),
	require("plugins.completion"),
	require("plugins.file_explorer"),
	require("plugins.icons"),
	require("plugins.treesitter"),
	require("plugins.gitsigns"),
	require("plugins.copilot"),
	require("plugins.notify"),
	require("plugins.tmux_statusline"),
}, {
	ui = {
		border = "rounded",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

