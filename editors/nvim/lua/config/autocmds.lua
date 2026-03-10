-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Open PDF files with PDFview plugin
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*.pdf",
	callback = function()
		local file_path = vim.api.nvim_buf_get_name(0)
		require("pdfview").open(file_path)
	end,
})
