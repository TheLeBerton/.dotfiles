require("gitsigns").setup({
	signs = {
		add          = { text = '+' },
		change       = { text = '~' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		vim.keymap.set('n', ']c', function()
		if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, {expr=true, buffer = bufnr, desc = "Next git change"})

		vim.keymap.set('n', '[c', function()
		if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, {expr=true, buffer = bufnr, desc = "Previous git change"})
      vim.keymap.set('n', '<leader>hs', gs.stage_hunk, {buffer = bufnr, desc = "Stage hunk"})
      vim.keymap.set('n', '<leader>hr', gs.reset_hunk, {buffer = bufnr, desc = "Reset hunk"})
      vim.keymap.set('n', '<leader>hp', gs.preview_hunk, {buffer = bufnr, desc = "Preview hunk"})
      vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, {buffer = bufnr, desc = "Git blame line"})
	end,
})
