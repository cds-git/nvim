return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },
			keys = {
				{
					"<leader>du",
					function()
						require("dapui").toggle({})
					end,
					desc = "[DAP] UI",
				},
				{
					"<leader>de",
					function()
						require("dapui").eval()
					end,
					desc = "[DAP] Eval",
					mode = { "n", "v" },
				},
			},
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")

				dapui.setup(opts)

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
			end,
		},
	},
	config = function()
		local dap = require("dap")

		dap.adapters.coreclr = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "Attach",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
			{
				type = "coreclr",
				name = "Launch - netcoredbg",
				request = "launch",
				console = "integratedTerminal",
				program = function()
					if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
						require("utils").dotnet_build_project()
					end
					return require("utils").dotnet_get_dll_path()
				end,
			},
		}
		vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)
	end,
	keys = {
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "[DAP] Breakpoint Condition",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "[DAP] Toggle Breakpoint",
		},
		{
			"<leader>dC",
			function()
				require("dap").clear_breakpoints()
			end,
			{ desc = "[DAP] Clear all breakpoints" },
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "[DAP] Continue",
		},
		-- {
		-- 	"<leader>da",
		-- 	function()
		-- 		require("dap").continue({ before = get_args })
		-- 	end,
		-- 	desc = "Run with Args",
		-- },
		{
			"<leader>dR",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "[DAP] Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "[DAP] Go to Line (No Execute)",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "[DAP] Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "[DAP] Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "[DAP] Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "[DAP] Run Last",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "[DAP] Step Out",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "[DAP] Step Over",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "[DAP] Pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "[DAP] Toggle REPL",
		},
		{
			"<leader>dS",
			function()
				require("dap").session()
			end,
			desc = "[DAP] Session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "[DAP] Terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "[DAP] Widgets",
		},
		{
			"<F5>",
			function()
				-- (Re-)reads launch.json if present
				if vim.fn.filereadable(".vscode/launch.json") then
					require("dap.ext.vscode").load_launchjs(nil, { coreclr = { "cs" } })
				end
				require("dap").continue()
			end,
			{ desc = "[DAP] Start debugging from launch.json" },
		},
	},
}
