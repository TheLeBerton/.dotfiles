return {
{
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
	  library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	  },
	},
},
{
	"neovim/nvim-lspconfig",
	config = function()
		require('lspconfig').lua_ls.setup{}
		require('lspconfig').clangd.setup({
		  cmd = { "/usr/bin/clangd" },
		})
		require('lspconfig').pyright.setup{}
	end
}
}
