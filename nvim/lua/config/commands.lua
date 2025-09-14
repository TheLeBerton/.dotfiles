-- Custom commands
local M = {}

-- Function to show all keymaps in a floating window
function M.show_keymaps()
	local keymap_data = {
		{
			title = "🔍 TELESCOPE (Fuzzy Finding)",
			maps = {
				{ "<leader>pf", "Find files in project" },
				{ "<C-p>", "Find git files (like VSCode Ctrl+P)" },
				{ "<leader>ps", "Grep search (prompts for input)" },
				{ "<leader>vh", "Help tags" },
			}
		},
		{
			title = "🎯 HARPOON (Quick File Navigation)",
			maps = {
				{ "<leader>a", "Add current file to harpoon" },
				{ "<C-e>", "Toggle harpoon menu" },
				{ "<C-h>", "Jump to harpoon file 1" },
				{ "<C-t>", "Jump to harpoon file 2" },
				{ "<C-n>", "Jump to harpoon file 3" },
				{ "<C-s>", "Jump to harpoon file 4" },
				{ "<C-S-P>", "Previous harpoon file" },
				{ "<C-S-N>", "Next harpoon file" },
			}
		},
		{
			title = "🪟 WINDOW MANAGEMENT",
			maps = {
				{ "<C-h/j/k/l>", "Navigate between windows" },
				{ "<C-Up/Down>", "Resize window height" },
				{ "<C-Left/Right>", "Resize window width" },
			}
		},
		{
			title = "📄 BUFFER NAVIGATION",
			maps = {
				{ "<S-l>", "Next buffer" },
				{ "<S-h>", "Previous buffer" },
			}
		},
		{
			title = "✂️ TEXT MANIPULATION",
			maps = {
				{ "J (visual)", "Move selected text down" },
				{ "K (visual)", "Move selected text up" },
				{ "</>", "Indent left/right (stays in visual)" },
				{ "J (normal)", "Join lines, keep cursor position" },
				{ "<leader>p", "Paste without losing register" },
				{ "<leader>d", "Delete to void register" },
				{ "<leader>y", "Yank to system clipboard" },
				{ "<leader>Y", "Yank line to system clipboard" },
			}
		},
		{
			title = "🔍 SEARCH & NAVIGATION",
			maps = {
				{ "<C-d>", "Scroll down, center cursor" },
				{ "<C-u>", "Scroll up, center cursor" },
				{ "n", "Next search result, center cursor" },
				{ "N", "Previous search result, center cursor" },
				{ "<Esc>", "Clear search highlights" },
			}
		},
		{
			title = "💾 FILE OPERATIONS",
			maps = {
				{ "<leader>w", "Save file" },
				{ "<leader>q", "Quit" },
				{ "<leader>x", "Make file executable" },
				{ "<leader><leader>", "Source current file" },
			}
		},
		{
			title = "🔧 LSP (Language Server)",
			maps = {
				{ "gd", "Go to definition" },
				{ "gr", "Go to references" },
				{ "K", "Hover documentation" },
				{ "<leader>ca", "Code actions" },
				{ "<leader>rn", "Rename symbol" },
				{ "<leader>f", "Format code" },
			}
		},
		{
			title = "🩺 DIAGNOSTICS",
			maps = {
				{ "[d", "Previous diagnostic" },
				{ "]d", "Next diagnostic" },
				{ "<leader>e", "Open floating diagnostic" },
				{ "<leader>dl", "Open diagnostics list" },
			}
		},
		{
			title = "💡 COMPLETION (Insert Mode)",
			maps = {
				{ "<C-p>", "Previous completion item" },
				{ "<C-n>", "Next completion item" },
				{ "<C-y>", "Confirm completion" },
				{ "<C-Space>", "Trigger completion" },
			}
		},
		{
			title = "💬 COMMENTS & SURROUND",
			maps = {
				{ "gcc", "Comment/uncomment line" },
				{ "gc (visual)", "Comment/uncomment selection" },
				{ "cs\"'", "Change surrounding \" to '" },
				{ "ds\"", "Delete surrounding \"" },
				{ "ys<motion>\"", "Add \" around motion" },
			}
		},
		{
			title = "📁 FILE EXPLORER (Oil.nvim)",
			maps = {
				{ "-", "Open parent directory" },
				{ "<leader>-", "Open current directory" },
				{ "<CR>", "Enter directory/open file" },
				{ "<C-s>", "Open in vertical split" },
				{ "<C-h>", "Open in horizontal split" },
				{ "g.", "Toggle hidden files" },
			}
		},
		{
			title = "🔧 QUICK UTILS",
			maps = {
				{ "<leader>s", "Search & replace word under cursor" },
				{ "q", "Close help/info windows" },
				{ "jk", "Better escape (insert mode)" },
			}
		},
	}

	-- Create buffer content
	local lines = {}
	local highlights = {}

	-- Add header
	table.insert(lines, "")
	table.insert(lines, "⌨️  NEOVIM KEYMAPS REFERENCE")
	table.insert(lines, "Leader Key: <Space>")
	table.insert(lines, "")
	table.insert(lines, string.rep("═", 60))
	table.insert(lines, "")

	for _, section in ipairs(keymap_data) do
		-- Add section title
		table.insert(lines, section.title)
		table.insert(highlights, { line = #lines - 1, col_start = 0, col_end = -1, hl_group = "Title" })
		table.insert(lines, "")

		-- Add keymaps
		for _, map in ipairs(section.maps) do
			local key_desc = string.format("  %-20s │ %s", map[1], map[2])
			table.insert(lines, key_desc)
			-- Highlight the keymap part
			table.insert(highlights, { line = #lines - 1, col_start = 2, col_end = 22, hl_group = "Identifier" })
		end

		table.insert(lines, "")
	end

	-- Add footer
	table.insert(lines, string.rep("═", 60))
	table.insert(lines, "")
	table.insert(lines, "💡 Tip: Use 'q' to close this window")
	table.insert(lines, "🚀 Happy coding with your minimal setup!")

	-- Create floating window
	local width = 65
	local height = math.min(#lines + 2, vim.o.lines - 4)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "filetype", "keymaps")

	-- Create window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Keymaps Reference ",
		title_pos = "center",
	})

	-- Apply highlights
	local ns_id = vim.api.nvim_create_namespace("keymaps_highlight")
	for _, hl in ipairs(highlights) do
		vim.api.nvim_buf_add_highlight(buf, ns_id, hl.hl_group, hl.line, hl.col_start, hl.col_end)
	end

	-- Set up keymaps for the floating window
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>close<CR>", { silent = true })

	-- Set window options
	vim.api.nvim_win_set_option(win, "wrap", false)
	vim.api.nvim_win_set_option(win, "cursorline", true)
end

-- Create the command
vim.api.nvim_create_user_command("KeymapsShow", M.show_keymaps, {
	desc = "Show all available keymaps in a floating window"
})

-- Alternative shorter command
vim.api.nvim_create_user_command("Keymaps", M.show_keymaps, {
	desc = "Show all available keymaps in a floating window"
})

-- Even shorter alias
vim.api.nvim_create_user_command("Keys", M.show_keymaps, {
	desc = "Show all available keymaps in a floating window"
})

return M