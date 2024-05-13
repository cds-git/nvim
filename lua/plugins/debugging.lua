return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		-- Start debugging session
		vim.keymap.set("n", "<leader>dS", function()
			dap.continue()
			dapui.toggle({})
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
		end, { desc = "Debug start" })

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debugger continue" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<leader>dC", function()
			dap.clear_breakpoints()
		end, { desc = "Clear all breakpoints" })

		-- Close debugger and clear breakpoints
		vim.keymap.set("n", "<leader>de", function()
			dapui.toggle({})
			dap.terminate()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
		end, { desc = "Debug end" })

		vim.keymap.set("n", "<F5>", function()
			-- (Re-)reads launch.json if present
			if vim.fn.filereadable(".vscode/launch.json") then
				require("dap.ext.vscode").load_launchjs(nil, { coreclr = { "cs" } })
			end
			require("dap").continue()
		end, { desc = "Start debugging from launch.json" })

		-- dap-ui setup
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		if not dap.adapters["coreclr"] then
			require("dap").adapters["coreclr"] = {
				type = "executable",
				command = "netcoredbg",
				args = { "--interpreter=vscode" },
			}
		end
		-- if not dap.configurations["cs"] then
		dap.configurations["cs"] = {
			{
				type = "coreclr",
				name = "Attach",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
			{
				type = "coreclr",
				name = "Launch file",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}
		-- end
	end,
}
