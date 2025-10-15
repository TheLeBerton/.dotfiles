return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet engine
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Completion sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-emoji",
			"petertriho/cmp-git",

			-- C/C++ specific
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"ray-x/cmp-treesitter",

			-- Visual enhancements
			"onsails/lspkind.nvim",
			"windwp/nvim-autopairs",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- Setup autopairs integration
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				-- VSCode-like completion window
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
					}),
				},

				-- Enhanced formatting with icons
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
						before = function(entry, vim_item)
							-- Source names for context
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								luasnip = "[Snippet]",
								buffer = "[Buffer]",
								path = "[Path]",
								cmdline = "[CMD]",
								git = "[Git]",
								emoji = "[Emoji]",
								treesitter = "[TS]",
							})[entry.source.name]
							return vim_item
						end,
					}),
				},

				-- VSCode-like keybindings
				mapping = cmp.mapping.preset.insert({
					-- Navigate completion menu
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),

					-- Scroll documentation
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					-- Trigger completion
					["<C-Space>"] = cmp.mapping.complete(),

					-- Close completion menu
					["<C-e>"] = cmp.mapping.abort(),

					-- Confirm completion (VSCode-like)
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false, -- Only confirm explicitly selected items
					}),

					-- Tab for snippet navigation and completion
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				-- Completion sources (ordered by priority)
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "nvim_lsp_signature_help", priority = 700 },
					{ name = "treesitter", priority = 600 },
				}, {
					{ name = "buffer", priority = 500, keyword_length = 3 },
					{ name = "path", priority = 250 },
					{ name = "emoji", priority = 100 },
				}),

				-- Enhanced completion behavior
				completion = {
					completeopt = "menu,menuone,noinsert",
				},

				-- Experimental features for better performance
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
			})

			-- Command line completion
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" }
				}
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" }
				}, {
					{ name = "cmdline" }
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})

			-- Git completion for commit messages
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				})
			})

			-- Configure git source
			require("cmp_git").setup()
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp", -- Optional for advanced regex features
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local luasnip = require("luasnip")

			-- Load VSCode-style snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

			-- Enhanced LuaSnip configuration
			luasnip.setup({
				history = true,
				delete_check_events = "TextChanged",
				region_check_events = "CursorMoved",
				enable_autosnippets = true,
				store_selection_keys = "<Tab>",
			})
		end,
	},

	-- LSP kind icons for completion menu
	{
		"onsails/lspkind.nvim",
		lazy = true,
	},

	-- Auto pairs for brackets, quotes, etc.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
					java = false,
				},
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
				fast_wrap = {
					map = "<M-e>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = [=[[%'%"%)%>%]%)%}%,]]=],
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})
		end,
	},
}