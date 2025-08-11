require("config.options")

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

require("config.auto_commands")
require("config.lazy")
require("config.keymaps")
require("config.colorscheme").toggle()
