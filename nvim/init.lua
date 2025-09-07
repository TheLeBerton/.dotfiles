print("Hey my guy")

require("config.options")
require("config.keymaps")
require("config.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
	vim.highlight.on_yank()
    end,
})
