require("config.colorscheme")

vim.keymap.set('n', '<leader>ff', "<cmd>lua require('fzf-lua').files()<CR>", { })
vim.keymap.set('n', '<leader>fg', "<cmd>lua require('fzf-lua').live_grep()<CR>", { })
vim.keymap.set('n', '<leader>fw', "<cmd>lua require('fzf-lua').grep_cword()<CR>", { })
vim.keymap.set('n', '<leader>tt', require("config.colorscheme").toggle, { desc = "Toggle theme light/dark" })
