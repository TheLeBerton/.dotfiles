-- Leader key must be set before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.commands")

-- Plugin management
require("config.lazy")