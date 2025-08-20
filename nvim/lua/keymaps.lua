vim.g.mapleader = ' '

local function set_keymap(mode, keys, command, opts)
  vim.keymap.set(mode, keys, command, opts)
end

set_keymap('n', '<leader>n', '<cmd>bn<cr>', { desc = "[B]uffer [N]ext" })
set_keymap('n', '<leader>p', '<cmd>bp<cr>', { desc = "[B]uffer [P]revious" })
set_keymap('n', '<leader>x', '<cmd>bd<cr>', { desc = "[B]uffer [D]elete" })
set_keymap('i', 'jk', '<Esc>', { desc = "Go to normal mode" })
