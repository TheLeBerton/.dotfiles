return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.minimal, -- Plus clean et minimaliste
				themable = true,
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				indicator = {
					icon = "│", -- Barre simple au lieu de ▎
					style = "icon",
				},
				buffer_close_icon = "×", -- Plus simple que 󰅖
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 25, -- Un peu plus petit
				max_prefix_length = 25,
				truncate_names = true,
				tab_size = 16, -- Beaucoup plus compact que 21
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					return "(" .. count .. ")"
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						text_align = "left",
						separator = true,
					},
				},
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = false, -- Masquer les X sur chaque onglet
				show_close_icon = false, -- Pas de X global non plus
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				persist_buffer_sort = true,
				separator_style = "thin", -- Fini les grosses flèches !
				enforce_regular_tabs = false, -- Plus de flexibilité
				always_show_bufferline = true,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				sort_by = "insert_after_current",
			},
		})
	end,
}