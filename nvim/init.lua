print("Hey my guy")

require("config.options")
require("config.keymaps")
require("config.lazy")

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
