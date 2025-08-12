vim.cmd("colorscheme catppuccin-macchiato")

require('bufferline').setup {}
require('autoclose').setup {}
require('lualine').setup {
	options = { theme = 'nord' }
}
require('noice').setup {}
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "python" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer", -- sélectionner une fonction entière
                ["if"] = "@function.inner", -- sélectionner le contenu d'une fonction
                ["ac"] = "@class.outer",    -- sélectionner une classe entière
                ["ic"] = "@class.inner",    -- sélectionner le contenu d'une classe
                -- tu peux ajouter d’autres objets ici
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
}
