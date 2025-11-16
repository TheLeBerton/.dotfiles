M = {}

M._project_root_cache = {}

function M.find_project_root()
	local cache_key = vim.fn.getcwd()
	if M._project_root_cache[cache_key] then
		return M._project_root_cache[cache_key]
	end
	local markers = {
		".git",
		"requirements.txt",
		"*.sln",
		"*.csproj",
		"Makefile",
		"CMakeLists.txt",
		"init.lua",
		".gitignore",
	}
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir = current_file ~= '' and
						vim.fn.fnamemodify(current_file, ":p:h") or
						vim.fn.getcwd()
	local found = vim.fs.find(markers, {
		path = current_dir,
		upward = true,
		limit = 1,
	})
	local root = found[1] and vim.fn.fnamemodify(found[1], ":p:h") or current_dir
	M._project_root_cache[cache_key] = root
	return root
end

function M.get_todo_file_path()
	local root = M.find_project_root()
	return root .. "/.mytodo"
end

function M.load_todo_content()
	local todo_path = M.get_todo_file_path()
	if vim.fn.filereadable(todo_path) == 1 then
		return vim.fn.readfile(todo_path)
	else
		return {
			"# TODO - " .. vim.fn.fnamemodify(M.find_project_root(), ":t"),
			"",
			"- [ ] ",
		}
	end
end

function M.save_todo_content()
	local current_buf = vim.api.nvim_get_current_buf()
	local content = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
	local todo_path = M.get_todo_file_path()

	vim.fn.writefile(content, todo_path)
	print("Saved to " .. todo_path)
end

-- Animation fade-in + scale pour l'ouverture
function M.animate_window_open(win_id, final_config)
	-- Commencer petit et transparent
	local start_config = vim.tbl_deep_extend("force", final_config, {
		width = math.floor(final_config.width * 0.3),
		height = math.floor(final_config.height * 0.3),
		row = final_config.row + math.floor(final_config.height * 0.35),
		col = final_config.col + math.floor(final_config.width * 0.35),
	})

	vim.api.nvim_win_set_config(win_id, start_config)
	vim.api.nvim_win_set_option(win_id, 'winblend', 95)

	-- Animation progressive
	local steps = 12
	local current_step = 0

	local timer = vim.loop.new_timer()
	timer:start(0, 25, vim.schedule_wrap(function()
		current_step = current_step + 1
		local progress = current_step / steps

		-- Easing function (smooth)
		local ease = 1 - math.pow(1 - progress, 3)

		local current_config = vim.tbl_deep_extend("force", final_config, {
			width = math.floor(start_config.width + (final_config.width - start_config.width) * ease),
			height = math.floor(start_config.height + (final_config.height - start_config.height) * ease),
			row = math.floor(start_config.row + (final_config.row - start_config.row) * ease),
			col = math.floor(start_config.col + (final_config.col - start_config.col) * ease),
		})

		local blend = math.floor(95 - (75 * ease))  -- 95 -> 20

		vim.api.nvim_win_set_config(win_id, current_config)
		vim.api.nvim_win_set_option(win_id, 'winblend', blend)

		if current_step >= steps then
			timer:stop()
			timer:close()
		end
	end))
end

function M.animate_close(win_id)
	local config = vim.api.nvim_win_get_config(win_id)
	local steps = 8
	local current_step = 0

	local timer = vim.loop.new_timer()
	timer:start(0, 30, vim.schedule_wrap(function()
		current_step = current_step + 1
		local progress = current_step / steps

		local blend = math.floor(20 + (75 * progress))  -- Convertir en entier
		local scale = 1 - (0.7 * progress)

		if vim.api.nvim_win_is_valid(win_id) then
			vim.api.nvim_win_set_option(win_id, 'winblend', blend)
			vim.api.nvim_win_set_config(win_id, vim.tbl_deep_extend("force", config, {
				width = math.floor(config.width * scale),
				height = math.floor(config.height * scale),
			}))
		end

		if current_step >= steps then
			if vim.api.nvim_win_is_valid(win_id) then
				vim.api.nvim_win_close(win_id, true)
			end
			timer:stop()
			timer:close()
		end
	end))
end

function M.open_todo_window()
	local todo_path = M.get_todo_file_path()
	local existing_buf = nil
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) == todo_path then
			existing_buf = buf
			break
		end
	end
	local buf
	if existing_buf then
		buf = existing_buf
		local content = M.load_todo_content()
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	else
		buf = vim.api.nvim_create_buf(false, true)
		local content = M.load_todo_content()
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
		vim.bo[buf].filetype = 'markdown'
		vim.bo[buf].buftype = 'acwrite'  -- permet :w mais intercepte l'écriture
		vim.api.nvim_buf_set_name(buf, M.get_todo_file_path())
		vim.api.nvim_create_autocmd("BufWriteCmd", {
			buffer = buf,
			callback = function()
				M.save_todo_content()
				vim.bo[buf].modified = false
			end
		})
	end
	local width = 60
	local height = math.min(25, vim.o.lines - 10)
	local final_opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2,
		border = "rounded",
		zindex = 50,
	}
	local win = vim.api.nvim_open_win(buf, true, final_opts)

	-- Ajouter keymaps pour fermer avec animation
	vim.keymap.set('n', 'q', function()
		M.animate_close(win)
	end, { buffer = buf, desc = 'Close todo with animation' })

	vim.keymap.set('n', '<Esc>', function()
		M.animate_close(win)
	end, { buffer = buf, desc = 'Close todo with animation' })

	-- Démarrer l'animation d'ouverture
	M.animate_window_open(win, final_opts)
end

vim.api.nvim_create_user_command("TodoOpen", M.open_todo_window, {
	desc = "Open project .mytodo file in floating window"
})

vim.api.nvim_create_user_command("TodoSave", function()
	M.save_todo_content() end, {
		desc = "Save current todo content to .mytodo file"
})

vim.api.nvim_create_user_command("TodoPrintPath", function()
	print(M.get_todo_file_path()) end, {
		desc = "Get current path to .mytodo file"
})

vim.api.nvim_create_user_command('Todo', function(opts)
	if opts.args == 'open' then
		M.open_todo_window()
	elseif opts.args == 'save' then
		M.save_todo_content()
	elseif opts.args == 'path' then
		print(M.get_todo_file_path())
	end
end, {
	nargs = 1,
	complete = function() return {'open', 'save'} end,
	desc = 'Todo commands'
})

return M
