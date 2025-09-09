vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohl<CR>")

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set('n', ']d', "lua: vim.diagnostic.goto_next()<cr>", { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', "lua: vim.diagnostic.goto_prev()<cr>", { desc = 'Previous diagnostic' })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    vim.cmd("silent! wa")
  end,
})
