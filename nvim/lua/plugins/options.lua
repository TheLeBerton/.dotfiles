vim.cmd("colorscheme catppuccin-macchiato")

require('bufferline').setup {}
require('autoclose').setup {}
require('lualine').setup {
	options = { theme = 'nord' }
}
require('noice').setup {}
