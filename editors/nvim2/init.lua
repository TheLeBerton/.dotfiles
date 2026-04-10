--:	Options
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
--:


--: Keymaps
local keys = vim.keymap
keys.set("n", "-", "<cmd>Oil<CR>")
keys.set("n", "<leader><leader>x", "<cmd> source %<CR>")
keys.set("v", ">", ">gv")
keys.set("v", "<", "<gv")
keys.set("n", "<leader>e", vim.diagnostic.open_float)
keys.set("n", "[d", vim.diagnostic.goto_prev)
keys.set("n", "]d", vim.diagnostic.goto_next)
keys.set( "n", "<C-f>", "<cmd>Telescope find_files<CR>" )
keys.set( "n", "<C-g>", "<cmd>Telescope live_grep<CR>" )
keys.set( "n", "<C-s>", "<cmd>Telescope grep_string<CR>" )


--: LSP
require( "lsp" ).setup()


--: Plugins
require( "plugins" ).setup()
