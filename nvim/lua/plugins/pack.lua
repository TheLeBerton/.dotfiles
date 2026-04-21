local M = {}

M.setup = function()
	vim.pack.add({
		-- Treesitter
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

		-- LSP
		 { src = "https://github.com/S1M0N38/love2d.nvim" },

		-- Oil
		{ src = "https://github.com/stevearc/oil.nvim" },
		{ src = "https://github.com/refractalize/oil-git-status.nvim" },
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

		-- Telescope
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

		-- UI
		{ src = "https://github.com/olimorris/onedarkpro.nvim", name = "onedarkpro" },
		{ src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" },
		{ src = "https://github.com/rebelot/kanagawa.nvim", name="kanagawa" },
		{ src = "https://github.com/ellisonleao/gruvbox.nvim", name="gruvbox" },
		{ src = 'https://github.com/shaunsingh/nord.nvim', name="nord" },
		{ src = "https://github.com/folke/tokyonight.nvim", name="tokyonight" },
		{ src = 'https://github.com/Mofiqul/dracula.nvim', name="dracula" },
		{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
		{ src = "https://github.com/zaldih/themery.nvim" },
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },
		{ src = "https://github.com/saghen/blink.cmp" },
		{ src = "https://github.com/folke/zen-mode.nvim" },
		{ src = "https://github.com/OXY2DEV/markview.nvim" },
		{ src = "https://github.com/folke/which-key.nvim" },
	})
end

return M
