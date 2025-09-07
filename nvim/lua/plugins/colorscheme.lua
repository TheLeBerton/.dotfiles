-- nvim/lua/plugins/everforest.lua
return {
	"sainnhe/everforest",
	priority = 1000,
	config = function()
		-- Available values: 'hard', 'medium'(default), 'soft'
		vim.g.everforest_background = 'soft'
		-- Available values: 'grey', 'green', 'blue'
		vim.g.everforest_cursor = 'auto'
		vim.g.everforest_transparent_background = 0
		vim.g.everforest_enable_italic = 1
		vim.g.everforest_disable_italic_comment = 0
		vim.g.everforest_show_eob = 1
		vim.g.everforest_diagnostic_text_highlight = 1
		vim.g.everforest_diagnostic_line_highlight = 1
		vim.g.everforest_diagnostic_virtual_text = 'colored'
		vim.g.everforest_better_performance = 1
		vim.cmd.colorscheme('everforest')
	end,
}
