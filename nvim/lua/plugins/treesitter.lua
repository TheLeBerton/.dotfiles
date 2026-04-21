local M = {}

M.setup = function ()
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

return M
