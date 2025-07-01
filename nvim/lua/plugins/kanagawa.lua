return {
  "Mofiqul/vscode.nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("vscode").setup({
      transparent = false, -- fond transparent
      italic_comments = true,
    })
    vim.cmd("colorscheme vscode")
  end,
}
