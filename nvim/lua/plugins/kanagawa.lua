return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
      background = "soft", -- or: medium, hard
      transparent_background_level = 1,
    })
    vim.cmd("colorscheme everforest")
  end,
}
