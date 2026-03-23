local M = {}

local wal_file = vim.fn.expand("~/.cache/wal/colors-neovim.lua")

function M.colors()
	local ok, wal = pcall(dofile, wal_file)
	if ok then return wal end
end

function M.apply()
	local wal = M.colors()

	require("kanagawa").setup({
		transparent = true,
		dimInactive = false,
		overrides = function(colors)
			local theme = colors.theme
			local base = {
				NormalFloat            = { bg = theme.ui.bg },
				FloatBorder            = { bg = theme.ui.bg, fg = theme.ui.nontext },
				FloatTitle             = { bg = theme.ui.bg },
				TelescopeBorder        = { fg = theme.ui.nontext, bg = "none" },
				TelescopeNormal        = { bg = "none" },
				TelescopePromptNormal  = { bg = "none" },
				TelescopeResultsNormal = { bg = "none" },
				TelescopePreviewNormal = { bg = "none" },
				ZenBg                  = { bg = "none" },
			}
			if wal then
				local w                        = wal
				base.Function                  = { fg = w.blue }
				base.Keyword                   = { fg = w.purple, bold = true }
				base.Statement                 = { fg = w.purple }
				base.Conditional               = { fg = w.purple }
				base.Repeat                    = { fg = w.purple }
				base.String                    = { fg = w.green }
				base.Character                 = { fg = w.green }
				base.Number                    = { fg = w.yellow }
				base.Float                     = { fg = w.yellow }
				base.Boolean                   = { fg = w.yellow }
				base.Type                      = { fg = w.aqua }
				base.StorageClass              = { fg = w.aqua }
				base.Structure                 = { fg = w.aqua }
				base.Identifier                = { fg = w.fg }
				base.Comment                   = { fg = w.fg_dim, italic = true }
				base.Special                   = { fg = w.yellow }
				base.Operator                  = { fg = w.red }
				base["@function"]              = { fg = w.blue }
				base["@function.call"]         = { fg = w.blue }
				base["@method"]                = { fg = w.blue }
				base["@method.call"]           = { fg = w.blue }
				base["@keyword"]               = { fg = w.purple, bold = true }
				base["@keyword.return"]        = { fg = w.purple }
				base["@keyword.function"]      = { fg = w.purple }
				base["@string"]                = { fg = w.green }
				base["@number"]                = { fg = w.yellow }
				base["@boolean"]               = { fg = w.yellow }
				base["@type"]                  = { fg = w.aqua }
				base["@type.builtin"]          = { fg = w.aqua }
				base["@variable"]              = { fg = w.fg }
				base["@variable.builtin"]      = { fg = w.red }
				base["@parameter"]             = { fg = w.fg }
				base["@field"]                 = { fg = w.fg }
				base["@property"]              = { fg = w.fg }
				base["@constructor"]           = { fg = w.aqua }
				base["@tag"]                   = { fg = w.red }
				base["@tag.attribute"]         = { fg = w.yellow }
				base["@tag.delimiter"]         = { fg = w.fg_dim }
				base["@comment"]               = { fg = w.fg_dim, italic = true }
				base["@operator"]              = { fg = w.red }
				base["@punctuation.bracket"]   = { fg = w.fg_dim }
				base["@punctuation.delimiter"] = { fg = w.fg_dim }
			end
			return base
		end,
	})
	vim.cmd.colorscheme("kanagawa-wave")
end

function M.watch()
	local watcher = vim.uv.new_fs_event()
	watcher:start(wal_file, {}, vim.schedule_wrap(function()
		M.apply()
		vim.notify("WAL theme reloaded", vim.log.levels.INFO)
	end))
end

return M
