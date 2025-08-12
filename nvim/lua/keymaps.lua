vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>n', '<cmd>bn<cr>', { desc = "[B]uffer [N]ext" })
vim.keymap.set('n', '<leader>p', '<cmd>bp<cr>', { desc = "[B]uffer [P]revious" })
vim.keymap.set('n', '<leader>x', '<cmd>bd<cr>', { desc = "[B]uffer [D]elete" })
