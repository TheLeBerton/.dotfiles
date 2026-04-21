local M = {}

function M.setup()
	local keys = vim.keymap
	keys.set("n", "-", "<cmd>Oil<CR>")
	keys.set("n", "<leader><leader>x", "<cmd> source %<CR>", { desc = "Source current file" } )
	keys.set("v", ">", ">gv")
	keys.set("v", "<", "<gv")
	keys.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostics" })
	keys.set("n", "[d", vim.diagnostic.goto_prev)
	keys.set("n", "]d", vim.diagnostic.goto_next)
	keys.set( "n", "<C-f>", "<cmd>Telescope find_files<CR>" )
	keys.set( "n", "<C-g>", "<cmd>Telescope live_grep<CR>" )
	keys.set( "n", "<C-s>", "<cmd>Telescope grep_string<CR>" )
end

return M
