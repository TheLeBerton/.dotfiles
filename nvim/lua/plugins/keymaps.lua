vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "[F]ind [F]iles" })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = "[F]ind [G]rep" })
vim.keymap.set('n', '<leader>fw', '<cmd>Telescope grep_string<cr>', { desc = "[F]ind [W]ord" })
vim.keymap.set('n', '<leader>e', "<cmd>lua require('oil').open_float('.')<cr>", { desc = "Open parent directory" })
