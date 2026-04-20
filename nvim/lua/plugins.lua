local M = {}

local setup_treesitter = function()
	vim.pack.add({
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter" }
	})
	require("nvim-treesitter").setup({
		ensure_installed = {
			"bash", "blade", "c", "comment", "css", "diff", "dockerfile",
			"fish", "gitignore", "go", "gomod", "gosum", "gowork", "html",
			"ini", "javascript", "jsdoc", "json", "lua", "luadoc", "luap",
			"make", "markdown", "markdown_inline", "nginx", "nix", "proto",
			"python", "query", "regex", "rust", "scss", "sql", "terraform",
			"toml", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml", "zig",
		}
	})
end

local setup_themery = function ()
	vim.pack.add( {
		{ src = "https://github.com/zaldih/themery.nvim" }
	})
	require( "themery" ).setup({
		themes = vim.fn.getcompletion( "", "color" )
	})
end

local setup_colorscheme = function()
	vim.pack.add({
		{ src = "https://github.com/olimorris/onedarkpro.nvim", name = "onedarkpro" },
		{ src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" },
		{ src = "https://github.com/rebelot/kanagawa.nvim", name="kanagawa" },
		{ src = "https://github.com/ellisonleao/gruvbox.nvim", name="gruvbox" },
		{ src = 'https://github.com/shaunsingh/nord.nvim', name="nord" },
		{ src = "https://github.com/folke/tokyonight.nvim", name="tokyonight" },
		{ src = 'https://github.com/Mofiqul/dracula.nvim', name="dracula" },
		{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" }
	})
	setup_themery()
	local wal = require( "wal" )
	wal.apply()
	wal.watch()
end


local setup_oil = function()
	vim.pack.add({
		{ src = "https://github.com/stevearc/oil.nvim" },
		{ src = "https://github.com/refractalize/oil-git-status.nvim" },
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" }
	})
	require( "oil" ).setup({
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
		},
		win_options = {
			signcolumn = "yes:2"
		},
		keymaps = {
			["q"] = "actions.close",
			["<C-c>"] = "actions.close",
		},
	})
	require( "oil-git-status" ).setup({})
end


local setup_telescope = function()
	vim.pack.add({
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" }
	})
	require( "telescope" ).setup()
	require( "telescope" ).load_extension( "fzf" )
end

local setup_gitsigns = function()
	vim.pack.add({
		{ src = "https://github.com/lewis6991/gitsigns.nvim" }
	})
	require( "gitsigns" ).setup()
end

local setup_blink = function()
	vim.pack.add({
		{ src = "https://github.com/saghen/blink.cmp" }
	})
	require( "blink.cmp" ).setup({
		keymap = {
			[ "<Tab>" ] = { "select_next", "fallback" },
			[ "<S-Tab>" ] = { "select_prev", "fallback" },
			[ "<CR>" ] = { "select_and_accept", "fallback" }
		},
		fuzzy = { implementation = "prefer_rust" },
		sources = { default = { "lsp", "buffer", "path" } },
		completion = {
			menu = { border = "none" },
			documentation = {
				auto_show = true,
				window = { border = "none" }
			},
			ghost_text = { enabled = true }
		}
	})
end

local install_loved2d = function ()
	vim.pack.add({
		{ src = "https://github.com/S1M0N38/love2d.nvim" }
	})
end

local setup_conform = function ()
	vim.pack.add({
		{ src = "https://github.com/stevearc/conform.nvim" }
	})
	-- require( "conform.nvim" ).setup()
end

local setup_zen = function ()
	vim.pack.add({
		{ src = "https://github.com/folke/zen-mode.nvim" }
	})
	require( "zen-mode" ).setup()
end

local setup_markview = function ()
	vim.pack.add({
		{ src = "https://github.com/OXY2DEV/markview.nvim" }
	})
end

local setup_which_key = function ()
	vim.pack.add({
		{ src = "https://github.com/folke/which-key.nvim" }
	})
	require( "which-key" ).setup()
end


M.setup = function()
	setup_treesitter()
	setup_colorscheme()
	setup_oil()
	setup_telescope()
	setup_gitsigns()
	setup_blink()
	setup_conform()
	install_loved2d()
	setup_zen()
	setup_markview()
	setup_which_key()
end


return M
