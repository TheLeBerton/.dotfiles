return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v4.x',
		lazy = true,
		config = false,
	},
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = true,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{'L3MON4D3/LuaSnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
		},
		config = function()
			local cmp = require('cmp')

			cmp.setup({
				sources = {
					{name = 'nvim_lsp'},
					{name = 'buffer'},
					{name = 'path'},
				},
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<C-k>'] = cmp.mapping.select_prev_item(),
					['<C-j>'] = cmp.mapping.select_next_item(),
					['<CR>'] = cmp.mapping.confirm({select = false}),
				}),
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
			})
		end
	},

	-- LSP
	{
		'neovim/nvim-lspconfig',
		cmd = {'LspInfo', 'LspInstall', 'LspStart'},
		event = {'BufReadPre', 'BufNewFile'},
		dependencies = {
			{'hrsh7th/cmp-nvim-lsp'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
		},
		config = function()
			local lsp_zero = require('lsp-zero')

			-- lsp_zero will use these settings for all servers
			lsp_zero.extend_lspconfig({
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
				lsp_attach = function(client, bufnr)
					-- Simple keymaps
					local opts = {buffer = bufnr}
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
				end
			})

			-- Setup Mason with servers
			require('mason-lspconfig').setup({
				ensure_installed = {'lua_ls', 'pyright'},
				handlers = {
					-- Default handler for all servers
					function(server_name)
						require('lspconfig')[server_name].setup({})
					end,
				}
			})

			-- Setup clangd manually (system version) - keep working version despite warning
			require('lspconfig').clangd.setup({
				cmd = {'clangd', '--background-index'},
				filetypes = {'c', 'cpp', 'objc', 'objcpp'},
			})
		end
	}
}