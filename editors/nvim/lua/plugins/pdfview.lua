return {
	"basola21/PDFview",
	lazy = false,
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "pdfview",
			callback = function()
				local renderer = require("pdfview.renderer")
				local buf = vim.api.nvim_get_current_buf()
				vim.keymap.set("n", "]]", renderer.next_page, { buffer = buf, desc = "PDF next page" })
				vim.keymap.set("n", "[[", renderer.previous_page, { buffer = buf, desc = "PDF previous page" })
			end,
		})
	end,
}
