local M = {}

function M.setup()
	vim.g.mapleader = " "
	vim.o.number = true
	vim.o.relativenumber = true
	vim.o.scrolloff = 16
	vim.o.shiftwidth = 4
	vim.o.tabstop = 4
	vim.o.signcolumn = "auto"
	vim.o.smartindent = true
	vim.o.swapfile = false
	vim.o.termguicolors = true
	vim.o.wrap = false
	vim.o.clipboard = "unnamedplus"
	vim.o.completeopt = "menuone,noinsert,noselect"
end

return M
