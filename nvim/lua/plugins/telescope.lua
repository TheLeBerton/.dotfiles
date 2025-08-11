return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        defaults = {
            layout_config = {
                horizontal = { width = 0.9 },
            },
            sorting_strategy = "ascending",
            winblend = 10,
        }
    }
}
