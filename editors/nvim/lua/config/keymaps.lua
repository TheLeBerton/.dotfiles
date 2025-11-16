local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<leader>w", ":w<CR>", { desc = "Save" })
keymap("n", "<leader>q", ":q<CR>", { desc = "[Q]uit" })
keymap("n", "<leader>wq", ":wq<CR>", { desc = "Save and [Q]uit" })

keymap("i", "jj", "<ESC>", { desc = "Normal mode" })

keymap("n", "<C-d>", "<C-d>zz", { desc = "Go down half page and recenter" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Go up half page and recenter" })

keymap("v", "<", "<gv", { desc = "De Indent and keep selection" })
keymap("v", ">", ">gv", { desc = "Indent and keep selection" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Formatting
keymap("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "[F]ormat buffer" })

keymap("v", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "[F]ormat selection" })

-- Telescope
local t_builtin = require("telescope.builtin")
keymap("n", "<C-f>", t_builtin.find_files, { desc = "Find [F]iles" })
keymap("n", "<C-g>", t_builtin.live_grep, { desc = "Live [G]rep" })
keymap("n", "<C-g>w", t_builtin.grep_string, { desc = "Grep [W]ord" })
keymap("n", "<C-h>", t_builtin.help_tags, { desc = "[H]elp Tags" })




-- Oil
local oil = require("oil")
keymap("n", "-", oil.toggle_float, { desc = "Oil Toggle float" })

-- Copilot
keymap("n", "<leader>cp", function() require("copilot.panel").open({}) end, { desc = "Copilot panel" })
keymap("n", "<leader>cs", "<cmd>Copilot status<CR>", { desc = "Copilot status" })
keymap("n", "<leader>ce", "<cmd>Copilot enable<CR>", { desc = "Copilot enable" })
keymap("n", "<leader>cd", "<cmd>Copilot disable<CR>", { desc = "Copilot disable" })
