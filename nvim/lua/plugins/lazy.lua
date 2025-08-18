-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{ "catppuccin/nvim",               name = "catppuccin", priority = 1000 },
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.8',       dependencies = { 'nvim-lua/plenary.nvim' } },
	{ 'akinsho/bufferline.nvim',       version = "*",       dependencies = 'nvim-tree/nvim-web-devicons' },
	{ 'm4xshen/autoclose.nvim' },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		lazy = false,
	},
	{ 'nvim-treesitter/nvim-treesitter-textobjects' },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},
	{ 'nvim-lualine/lualine.nvim',                  dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		lazy = false,
	},


	-- Mason
	{
		'williamboman/mason.nvim',
		lazy = false,
		opts = {},
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				sources = { { name = 'nvim_lsp' } },
				mapping = cmp.mapping.preset.insert({
					['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.snippet and vim.snippet.active({ direction = 1 }) then
							vim.snippet.jump(1)
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.snippet and vim.snippet.active({ direction = -1 }) then
							vim.snippet.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
			})
		end,
	},

	-- LSP
	{
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
	},
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.c",
    callback = function()
        require("function_length").show_function_lengths()
    end,
})

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    pattern = "*.c",
    callback = function()
        require("function_length").show_function_lengths()
    end,
})
