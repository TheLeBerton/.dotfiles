local M = {}

-- treesitter
local _treesitter = function ()
	vim.pack.add({
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
		{ src = "https://github.com/S1M0N38/love2d.nvim" }
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

-- markview
local _markview = function ()
	vim.pack.add({
		{ src = "https://github.com/OXY2DEV/markview.nvim" },
	})
	require( "markview" ).setup()
end

-- blink
local _blink = function ()
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

M.setup = function ()
	_treesitter()
	_markview()
	_blink()
end

return M
