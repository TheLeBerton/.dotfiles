-- Keymaps (ThePrimeagen/TJ inspired)
local keymap = vim.keymap.set

-- Disable arrow keys (train yourself!)
keymap({ "n", "i", "v" }, "<Left>", "<cmd>echo 'Use h to move!!'<CR>")
keymap({ "n", "i", "v" }, "<Right>", "<cmd>echo 'Use l to move!!'<CR>")
keymap({ "n", "i", "v" }, "<Up>", "<cmd>echo 'Use k to move!!'<CR>")
keymap({ "n", "i", "v" }, "<Down>", "<cmd>echo 'Use j to move!!'<CR>")

-- Better escape
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Better indenting
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Keep cursor in place when joining lines
keymap("n", "J", "mzJ`z", { desc = "Join lines" })

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
keymap("n", "n", "nzzzv", { desc = "Next search result" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Paste without losing register
keymap("x", "<leader>p", '"_dP', { desc = "Paste without losing register" })

-- Delete to void register
keymap({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void register" })

-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Quick file operations
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Quick search replace
keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "Replace word under cursor" })

-- Make file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Source current file
keymap("n", "<leader><leader>", function()
	vim.cmd("so")
end, { desc = "Source current file" })

-- Clear highlights
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })