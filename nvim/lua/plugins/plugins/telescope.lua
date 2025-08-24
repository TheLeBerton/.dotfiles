return {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
				'nvim-lua/plenary.nvim',
				{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
		},
		config = function()
				require('telescope').setup {
						pickers = {
								find_files = {
										theme = "ivy"
								},
								live_grep = {
										theme = "ivy"
								},
								grep_string = {
										theme = "ivy"
								},
								lsp_implementations = {
										theme = "ivy"
								},
								lsp_type_definitions = {
										theme = "ivy"
								},
								lsp_references = {
										theme = "ivy"
								}
						}
				}
		end
}
