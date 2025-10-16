-- C/C++ plugins - keeping minimal set
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

			-- GDB adapter for C/C++
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" }
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
				},
			}
			dap.configurations.cpp = dap.configurations.c

			-- Debug keymaps
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		end,
	},
}