return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			-- Helper function for LSP setup with compatibility
			local function setup_lsp(server_name, config)
				if vim.lsp.config then
					vim.lsp.config(server_name, config)
				else
					require("lspconfig")[server_name].setup(config)
				end
			end

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ruff",
					"bashls",
					"html",
					"cssls",
					"ts_ls",
					"emmet_ls",
					"jsonls",
				},
				handlers = {
					function(server_name)
						setup_lsp(server_name, { capabilities = capabilities })
					end,

					["lua_ls"] = function()
						setup_lsp("lua_ls", {
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
									},
								},
							},
						})
					end,

					["html"] = function()
						setup_lsp("html", {
							capabilities = capabilities,
							filetypes = { "html", "htm" },
						})
					end,

					["cssls"] = function()
						setup_lsp("cssls", {
							capabilities = capabilities,
							filetypes = { "css", "scss", "less" },
						})
					end,

					["ts_ls"] = function()
						setup_lsp("ts_ls", {
							capabilities = capabilities,
							filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
						})
					end,

					["emmet_ls"] = function()
						setup_lsp("emmet_ls", {
							capabilities = capabilities,
							filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
						})
					end,

					["jsonls"] = function()
						setup_lsp("jsonls", {
							capabilities = capabilities,
							filetypes = { "json", "jsonc" },
						})
					end,

					["pyright"] = function()
						setup_lsp("pyright", {
							capabilities = capabilities,
							settings = {
								python = {
									analysis = {
										typeCheckingMode = "basic", -- "off", "basic", "strict"
										autoSearchPaths = true,
										useLibraryCodeForTypes = true,
										diagnosticMode = "workspace",
										-- Ignore common virtual environment directories
										ignore = { "**/node_modules", "**/__pycache__", ".venv", "venv" },
									},
								},
							},
						})
					end,

					["ruff"] = function()
						setup_lsp("ruff", {
							capabilities = capabilities,
							init_options = {
								settings = {
									-- Ruff settings (linting, formatting)
									lint = {
										-- Enable all rules by default, or specify which ones
										select = { "E", "F", "I", "N", "W" },
									},
								},
							},
						})
					end,
				},
			})

			-- Setup system clangd manually
			setup_lsp("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
			})

			vim.diagnostic.config({
				virtual_text = {
					enabled = true,
					source = "if_many",
					prefix = "●", -- Could be '■', '▎', 'x'
				},
				signs = true,
				underline = true,
				update_in_insert = true, -- Show diagnostics while typing
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- LSP keymaps (set globally)
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})
		end,
	},
}