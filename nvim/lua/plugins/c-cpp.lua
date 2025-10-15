-- Enhanced C/C++ development plugins
return {

	-- Debugging support
	{
		"mfussenegger/nvim-dap",
		ft = { "c", "cpp" },
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup DAP UI
			dapui.setup()

			-- Virtual text for debugging
			require("nvim-dap-virtual-text").setup()

			-- GDB/LLDB adapter for C/C++
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" }
			}

			dap.adapters.lldb = {
				type = "executable",
				command = "lldb-vscode", -- adjust as needed
				name = "lldb"
			}

			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
			}
			dap.configurations.cpp = dap.configurations.c

			-- Auto open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Debug keymaps
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
			end, { desc = "Set Conditional Breakpoint" })
		end,
	},

	-- Enhanced C/C++ syntax highlighting
	{
		"jackguo380/vim-lsp-cxx-highlight",
		ft = { "c", "cpp" },
		config = function()
			vim.g.lsp_cxx_hl_use_text_props = 1
		end,
	},

	-- Header/source switching
	{
		"ericcurtin/CurtineIncSw.vim",
		ft = { "c", "cpp" },
		config = function()
			vim.keymap.set("n", "<leader>a", "<cmd>call CurtineIncSw()<cr>", { desc = "Switch Header/Source" })
		end,
	},

	-- Better C++ syntax
	{
		"octol/vim-cpp-enhanced-highlight",
		ft = { "cpp" },
		config = function()
			vim.g.cpp_class_scope_highlight = 1
			vim.g.cpp_member_variable_highlight = 1
			vim.g.cpp_class_decl_highlight = 1
			vim.g.cpp_posix_standard = 1
			vim.g.cpp_experimental_simple_template_highlight = 1
			vim.g.cpp_concepts_highlight = 1
		end,
	},
}