return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup({
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "Git blame line" })
					map('n', '<leader>gp', gs.preview_hunk, { desc = "Preview hunk" })
					map('n', '<leader>gr', gs.reset_hunk, { desc = "Reset hunk" })
					map('n', '<leader>gs', gs.stage_hunk, { desc = "Stage hunk" })
				end
			})
		end
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{ "<leader>gg", "<cmd>Git<cr>",        desc = "Git status" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
			{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
		}
	}
}
