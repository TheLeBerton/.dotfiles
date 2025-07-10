return {
	{ 'echasnovski/mini.nvim', version = '*' },
	{ 'echasnovski/mini.completion', version = '*',
	config = function()
		require('mini.completion').setup()
	end
	}
}
