local M = {}

local function map(buf, keys, func, desc)
	vim.keymap.set("n", keys, func, {
		buffer = buf,
		desc = "LSP" .. desc,
	})
end

local function setup_buffer_keymaps(bufnr)
	map(bufnr, "K", vim.lsp.buf.hover, "Hover Documentation")
	map(bufnr, "gd", vim.lsp.buf.definition, "Goto Definition")
	map(bufnr, "gD", vim.lsp.buf.declaration, "Goto Declaration")
	map(bufnr, "gr", vim.lsp.buf.references, "Show References")
	map(bufnr, "gi", vim.lsp.buf.implementation, "Goto Implementation")

	map(bufnr, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
	map(bufnr, "<leader>rn", vim.lsp.buf.rename, "Rename")
	map(bufnr, "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, "Format")

	map(bufnr, "]d", vim.diagnostic.goto_next, "Next Diagnostic")
	map(bufnr, "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
	map(bufnr, "<leader>e", vim.diagnostic.open_float, "Show Diagnostic")
end

function M.setup()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			setup_buffer_keymaps(ev.buf)
		end,
	})
end

return M
