local M = {}

function M.setup()
	vim.diagnostic.config({
		float = { border = "rounded" },
		virtual_text = true,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})
end

return M
