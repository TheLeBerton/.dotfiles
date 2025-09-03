return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
	  harpoon:setup({
		  settings = {
			  save_on_toggle = true,
			  sync_on_ui_close = true,
			  key = function()
				  return vim.loop.cwd()
			  end,
		  },
	  })
	  local keymap = vim.keymap.set
	  keymap("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
	  keymap("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })
	  keymap("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
	  keymap("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
	  keymap("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
	  keymap("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })
	  keymap("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon: Next" })
	  keymap("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon: Previous" })
	  keymap("n", "<leader>hd", function() harpoon:list():remove() end, { desc = "Harpoon: Delete file" })
	  keymap("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "Harpoon: Empty list" })
  end,
  },
}
