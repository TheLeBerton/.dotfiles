return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					local opts = { buffer = args.buf }
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)

					-- if client.supports_method('textDocument/formatting', 0) then
					-- 	vim.api.nvim_create_autocmd('BufWritePre', {
						-- 		buffer = args.buf,
						-- 		callback = function()
							-- 			vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							-- 		end,
							-- 	})
							-- end
						end,
					})
				end
			}
		}
