local M = {}

function M.show_function_lengths()
	local bufnr = vim.api.nvim_get_current_buf()
	local ns_id = vim.api.nvim_create_namespace("FunctionLength")
	vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for i = 1, #lines do
		local line = lines[i]
		if line:match("^[%w_][%w%d_ *]-[%*&]*%s+[%w_]+%s*%b()%s*$") then
			local start_line = i - 1
			local depth = 0
			local found = false
			local end_line = start_line
			for j = i, #lines do
				for c in lines[j]:gmatch(".") do
					if c == "{" then depth = depth + 1 end
					if c == "}" then
						depth = depth - 1
						if depth == 0 then
							end_line = j - 1
							found = true
							break
						end
					end
				end
				if found then break end
			end
			local func_name = line:match("([%w_]+)%s*%b()%s*$") or "?"
			local length = end_line - start_line - 2
			local virt_text = {
				{
					(length > 25 and "!! " or "") .. func_name .. " : " .. length .. " lignes",
					(length > 25 and "Error" or "Comment")
				}
			}
			vim.api.nvim_buf_set_extmark(bufnr, ns_id, start_line, 0, {
				virt_lines = { virt_text },
				virt_lines_above = true,
			})
		end
	end
end

return M
