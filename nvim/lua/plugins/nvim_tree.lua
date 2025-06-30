return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = { width = 30, side = "left", relativenumber = true },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = { show = { git = true, folder = true, file = true, folder_arrow = true } },
        },
        update_focused_file = { enable = true, update_cwd = true },
        git = { enable = true },
      })

      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
    end,
  },
}

