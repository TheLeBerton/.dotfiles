return
{
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP source
		"hrsh7th/cmp-buffer",  -- Buffer source
		"hrsh7th/cmp-path",    -- Path source
		"L3MON4D3/LuaSnip",    -- Snippet engine
		"saadparwaiz1/cmp_luasnip", -- Snippet source
		"zbirenbaum/copilot-cmp"
	},
	config = function()
		require("copilot_cmp").setup()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "copilot", priority = 100 },
				{ name = "nvim_lsp", priority = 90 },
				{ name = "luasnip", priority = 80 },
				{ name = "buffer", priority = 50 },
				{ name = "path", priority = 40 }
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})
	end,
}
