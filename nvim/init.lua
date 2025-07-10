vim.o.number = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.signcolumn = 'yes'
vim.o.undofile = true
vim.o.cursorline = true

local ok_theme = pcall(vim.cmd.colorscheme('retrobox'))
if not ok_theme then
	vim.cmd.colorscheme('habamax')
end

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

require("config.lazy")
require("config.keymaps")
