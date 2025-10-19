local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<leader>w", ":w<CR>", { desc = "Save" })
keymap("n", "<leader>q", ":q<CR>", { desc = "[Q]uit" })
keymap("n", "<leader>wq", ":wq<CR>", { desc = "Save and [Q]uit" })

keymap("i", "jj", "<ESC>", { desc = "Normal mode" })

keymap("n", "-", ":Ex<CR>", { desc = "Open Files" })



-- Telescope
local t_builtin = require("telescope.builtin")
keymap("n", "<C-f>", t_builtin.find_files, { desc = "Find [F]iles" })
keymap("n", "<C-g>", t_builtin.live_grep, { desc = "Live [G]rep" })
keymap("n", "<C-w>", t_builtin.grep_string, { desc = "Grep [W]ord" })
keymap("n", "<C-h>", t_builtin.help_tags, { desc = "[H]elp Tags" })




-- Oil
local oil = require("oil")
keymap("n", "-", oil.toggle_float, { desc = "Oil Toggle float" })
