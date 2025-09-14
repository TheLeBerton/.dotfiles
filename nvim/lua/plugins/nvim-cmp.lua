return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- LSP completion source
			"hrsh7th/cmp-nvim-lsp",
			-- Buffer completion source
			"hrsh7th/cmp-buffer",
			-- Path completion source
			"hrsh7th/cmp-path",
			-- Command line completion
			"hrsh7th/cmp-cmdline",
			-- Snippet engine (required by nvim-cmp)
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Optional: friendly snippets collection
			"rafamadriz/friendly-snippets",
			{
				"zbirenbaum/copilot-cmp",
				dependencies = "zbirenbaum/copilot.lua",
			},
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			-- Load friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						border = "none",
					},
					documentation = {
						border = "none",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					-- Tab completion like VSCode
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp", group_index = 2 }, -- LSP completions
					{ name = "luasnip", group_index = 2 },  -- Snippet completions
				}, {
					{ name = "buffer" },   -- Buffer completions
					{ name = "path" },     -- File path completions
				}),
				-- VSCode-like completion appearance
				formatting = {
					format = function(entry, vim_item)
						-- Kind icons
						local kind_icons = {
							Text = "",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰇽",
							Variable = "󰂡",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏘",
							File = "󰈙",
							Reference = "",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "󰅲",
							Copilot = "",
						}
						if entry.source.name == "copilot" then
							vim_item.kind = string.format('%s %s', kind_icons["Copilot"], "Copilot")
						else
							vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
						end
						vim_item.menu = ({
							copilot = "[Copilot]",
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end
				},
				-- Enable auto-trigger (like VSCode)
				completion = {
					autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						require("copilot_cmp.comparators").prioritize,
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					}
				},
			})

			-- Command line completion
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})
		end,
	},
}
