-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.colorcolumn = "80"
opt.showmode = false

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Timing
opt.updatetime = 250
opt.timeoutlen = 300

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Borders
opt.winborder = "rounded"

-- Background
opt.background = "dark"
