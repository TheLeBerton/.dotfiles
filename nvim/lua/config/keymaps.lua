local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<C-h>", "<C-w>h", { desc = "Window left" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Window down" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Window up" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Window right" })

keymap("n", "<leader>w", ":w<CR>", { desc = "Save" })

keymap("i", "jj", "<ESC>", { desc = "Normal mode" })

keymap("n", "-", ":Ex<CR>", { desc = "Open Files" })



-- Telescope
local t_builtin = require("telescope.builtin")
keymap("n", "<C-f>", t_builtin.find_files, { desc = "Find [F]iles" })
keymap("n", "<C-g>", t_builtin.live_grep, { desc = "Live [G]rep" })
keymap("n", "<C-w>", t_builtin.grep_string, { desc = "Grep [W]ord" })
keymap("n", "<C-h>", t_builtin.help_tags, { desc = "[H]elp Tags" })
