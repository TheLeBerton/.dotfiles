-- Autocommands (ThePrimeagen/TJ inspired)

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Auto save on focus lost
vim.api.nvim_create_autocmd("FocusLost", {
	desc = "Auto save when focus is lost",
	group = vim.api.nvim_create_augroup("auto-save", { clear = true }),
	pattern = "*",
	command = "silent! wa",
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Remove trailing whitespace on save",
	group = vim.api.nvim_create_augroup("trim-whitespace", { clear = true }),
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Return to last edit position when opening files",
	group = vim.api.nvim_create_augroup("last-position", { clear = true }),
	pattern = "*",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "Check if file needs to be reloaded",
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	command = "checktime",
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	desc = "Resize splits if window got resized",
	group = vim.api.nvim_create_augroup("resize-splits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	desc = "Close certain filetypes with <q>",
	group = vim.api.nvim_create_augroup("close-with-q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"checkhealth",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})