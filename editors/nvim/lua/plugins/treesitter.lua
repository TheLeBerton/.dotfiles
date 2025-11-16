require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cpp",
		"python",
		"lua",
		"bash",
		"vim",
		"vimdoc",
		"markdown",
		"json",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})
