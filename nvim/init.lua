print("leo leo nvim 2000")

require("config.lazy")

vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", "<cmd>:.lua<CR>")
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohl<CR>")
vim.keymap.set("n", "j", "jzz", { noremap = true, silent = true } )
vim.keymap.set("n", "k", "kzz", { noremap = true, silent = true } )

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
	vim.highlight.on_yank()
    end,
})
