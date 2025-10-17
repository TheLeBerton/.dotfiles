local servers = { "lua_ls", "clangd", "pyright" }
vim.lsp.enable(servers)

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
	virtual_lines = {
		current_line = true,
	},
	virtual_text = true,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
-- 	callback = function(event)
-- 		local map = function(keys, func, desc)
-- 			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
-- 		end
--
-- 		map("<leader>e", vim.diagnostic.open_float, "Open Diagnostic Float")
-- 		map("K", vim.lsp.buf.hover, "Hover Documentation")
-- 		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
-- 		map("gd", vim.lsp.buf.definition, "Goto Definition")
-- 		map("gr", vim.lsp.buf.references, "Show References")
-- 		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
-- 		map("<leader>rn", vim.lsp.buf.rename, "Rename all references")
-- 		map("<leader>lf", vim.lsp.buf.format, "Format")
-- 		map("]d", vim.diagnostic.goto_next, "Diagnostic Next")
-- 		map("[d", vim.diagnostic.goto_prev, "Diagnostic Prev")
--
-- 	end,
-- })


-- vim.diagnostic.config({
-- 	virtual_text = true,
-- 	underline = true,
-- 	update_in_insert = false,
-- 	severity_sort = true,
-- 	float = {
-- 		border = "single",
-- 		source = true,
-- 	},
-- })

-- vim.lsp.config.pyright = {
-- 	cmd = { "pyright-langserver", "--stdio" },
-- 	filetypes = { "python" },
-- 	on_attach = on_attach,
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				typeCheckingMode = "basic",
-- 			},
-- 		},
-- 	},
-- }

-- vim.lsp.config.bashls {
-- 	cmd = { "bash-language-server", "start" },
-- 	filetypes = { "sh", "bash" },	
-- 	on_attach = on_attach,
-- }
