local M = {}

local wal_file = vim.fn.expand("~/.cache/wal/nvim-theme")

function M.apply()
	local f = io.open( wal_file, "r" )
	local theme = f and f:read("*l") or "kanagawa-wave"
	if f then f:close() end
	vim.cmd.colorscheme(theme)
	vim.notify("WAL theme reloaded into " .. theme, vim.log.levels.INFO)
end

function M.watch()
	local watcher = vim.uv.new_fs_event()
	watcher:start(wal_file, {}, vim.schedule_wrap(function()
		M.apply()
	end))
end

return M
