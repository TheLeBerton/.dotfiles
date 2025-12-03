-- Charger la configuration personnalisée de clangd
vim.lsp.config.clangd = require('lsp.clangd')

-- Charger la config pour Makefile
vim.lsp.config.make_ls = {
	default_config = {
		cmd = { "make-lsp" },
		filetypes = { "make" },
		root_dir = vim.fs.dirname,
		settings = {}
	}
}

-- Activer les autres serveurs avec config par défaut
local servers = { "lua_ls", "pyright", "make-ls" }
vim.lsp.enable(servers)

-- Activer clangd avec la config personnalisée
vim.lsp.enable('clangd')
vim.lsp.enable("make_ls")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method('textDocument/completion') then
			-- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			-- vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
			end

			map("<leader>e", vim.diagnostic.open_float, "Open Diagnostic Float")
			map("K", vim.lsp.buf.hover, "Hover Documentation")
			map("gD", vim.lsp.buf.declaration, "Goto Declaration")
			map("gd", vim.lsp.buf.definition, "Goto Definition")
			map("gr", vim.lsp.buf.references, "Show References")
			map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			map("<leader>rn", vim.lsp.buf.rename, "Rename all references")
			map("<leader>lf", vim.lsp.buf.format, "Format")
			map("]d", vim.diagnostic.goto_next, "Diagnostic Next")
			map("[d", vim.diagnostic.goto_prev, "Diagnostic Prev")
		end
	end,
})

vim.diagnostic.config({
	float = { border = "rounded" },
	virtual_lines = { current_line = true },
	virtual_text = true,
})
