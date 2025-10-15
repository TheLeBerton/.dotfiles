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

-- VSCode-like completion highlights
vim.api.nvim_create_autocmd("ColorScheme", {
	desc = "Set VSCode-like completion highlights",
	group = vim.api.nvim_create_augroup("completion-highlights", { clear = true }),
	callback = function()
		local highlights = {
			-- Completion menu
			CmpPmenu = { bg = "#1e1e1e", fg = "#cccccc" },
			CmpSel = { bg = "#094771", fg = "#ffffff" },
			CmpDoc = { bg = "#1e1e1e" },
			CmpDocBorder = { bg = "#1e1e1e", fg = "#454545" },

			-- Completion item kinds (VSCode-like colors)
			CmpItemKindText = { fg = "#cccccc" },
			CmpItemKindMethod = { fg = "#b180d7" },
			CmpItemKindFunction = { fg = "#b180d7" },
			CmpItemKindConstructor = { fg = "#d7ba7d" },
			CmpItemKindField = { fg = "#9cdcfe" },
			CmpItemKindVariable = { fg = "#9cdcfe" },
			CmpItemKindClass = { fg = "#4ec9b0" },
			CmpItemKindInterface = { fg = "#4ec9b0" },
			CmpItemKindModule = { fg = "#4ec9b0" },
			CmpItemKindProperty = { fg = "#9cdcfe" },
			CmpItemKindUnit = { fg = "#d7ba7d" },
			CmpItemKindValue = { fg = "#d7ba7d" },
			CmpItemKindEnum = { fg = "#4ec9b0" },
			CmpItemKindKeyword = { fg = "#569cd6" },
			CmpItemKindSnippet = { fg = "#ce9178" },
			CmpItemKindColor = { fg = "#ce9178" },
			CmpItemKindFile = { fg = "#cccccc" },
			CmpItemKindReference = { fg = "#cccccc" },
			CmpItemKindFolder = { fg = "#cccccc" },
			CmpItemKindEnumMember = { fg = "#4ec9b0" },
			CmpItemKindConstant = { fg = "#4ec9b0" },
			CmpItemKindStruct = { fg = "#4ec9b0" },
			CmpItemKindEvent = { fg = "#d7ba7d" },
			CmpItemKindOperator = { fg = "#cccccc" },
			CmpItemKindTypeParameter = { fg = "#4ec9b0" },

			-- Ghost text
			CmpGhostText = { fg = "#6a6a6a", italic = true },

			-- Menu borders
			FloatBorder = { fg = "#454545" },
		}

		for group, opts in pairs(highlights) do
			vim.api.nvim_set_hl(0, group, opts)
		end
	end,
})

-- Apply highlights immediately
vim.schedule(function()
	vim.cmd("doautocmd ColorScheme")
end)