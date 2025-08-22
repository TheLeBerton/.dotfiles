return {
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
		},
		init = function()
			vim.opt.signcolumn = 'yes'
		end,
		config = function()
			local lsp_defaults = require('lspconfig').util.default_config
			lsp_defaults.capabilities = vim.tbl_deep_extend(
				'force',
				lsp_defaults.capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
					vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
					vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
					vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)
					vim.keymap.set('n', 'go', '<cmd>Telescope lsp_type_definitions<cr>', opts)
					vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
					vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
					vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
					vim.keymap.set({ 'n', 'x' }, '<leader>fo', function()
						if vim.bo.filetype == "c" or vim.bo.filetype == "h" then
							vim.cmd('%!clang-format')
						else
							vim.lsp.buf.format({ async = true })
						end
					end, { desc = "Format file" })
					vim.keymap.set('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<cr>', opts)
				end,
			})

			require('mason-lspconfig').setup({
				ensure_installed = { 'pyright', 'lua_ls', 'bashls' },
				handlers = {
					function(server_name)
						require('lspconfig')[server_name].setup({})
					end,
				},
			})
			require('lspconfig').clangd.setup({
				cmd = { "clangd" }, -- chemin vers clangd système (par défaut dans PATH)
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
			})
		end,
}
