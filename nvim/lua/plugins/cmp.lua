local cmp = require("cmp")

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
	}),
	completion = {
		completeopt = 'menu,menuone,noinsert,noselect',
	},
	experimental = {
		ghost_text = true,
	},
})
