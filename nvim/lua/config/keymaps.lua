require("config.colorscheme")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>')
vim.keymap.set('n', '<leader>ff', "<cmd>lua require('fzf-lua').files()<CR>", { })
vim.keymap.set('n', '<leader>fg', "<cmd>lua require('fzf-lua').live_grep()<CR>", { })
vim.keymap.set('n', '<leader>fw', "<cmd>lua require('fzf-lua').grep_cword()<CR>", { })
vim.keymap.set('n', '<leader>tt', require("config.colorscheme").toggle, { desc = "Toggle theme light/dark" })
