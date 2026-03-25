local M = {}

local wal_file = vim.fn.expand("~/.cache/wal/nvim-theme")

function M.colors()
	local ok, wal = pcall(dofile, wal_file)
	if ok then return wal end
end

function M.apply()
	local f = io.open(vim.fn.expand("~/.cache/wal/nvim-theme"), "r")
	local theme = f and f:read("*l") or "kanagawa-wave"
	if f then f:close() end
	vim.cmd.colorscheme(theme)
end

function M.watch()
	local watcher = vim.uv.new_fs_event()
	watcher:start(wal_file, {}, vim.schedule_wrap(function()
		M.apply()
		vim.notify("WAL theme reloaded", vim.log.levels.INFO)
	end))
end

return M
