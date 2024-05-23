return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"Issafalcon/neotest-dotnet",
	},
	config = function()
		require("neotest").setup({
			discovery = {
				enabled = false,
				concurrent = 0,
			},
			icons = {
				expanded = "",
				child_prefix = "",
				child_indent = "",
				final_child_prefix = "",
				non_collapsible = "",
				collapsed = "",

				passed = "",
				running = "",
				failed = "",
				unknown = "",
				running_animated = { "◴", "◷", "◶", "◵" },
			},
			adapters = {
				require("neotest-dotnet")({
					dap = {
						-- Extra arguments for nvim-dap configuration
						-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
						args = { justMyCode = false },
						-- Enter the name of your dap adapter, the default value is netcoredbg
						adapter_name = "coreclr",
					},
					-- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
					-- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
					custom_attributes = {
						xunit = { "MyCustomFactAttribute" },
						nunit = { "MyCustomTestAttribute" },
						mstest = { "MyCustomTestMethodAttribute" },
					},
					-- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
					dotnet_additional_args = {
						"--verbosity detailed",
					},
					-- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
					-- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
					--       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
					discovery_root = "project", -- Default
				}),
			},
		})

		local neotest = require("neotest")

		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "[NeoTest] Test file" })

		vim.keymap.set("n", "<leader>ta", function()
			neotest.run.run({ suite = true })
		end, { desc = "[NeoTest] Test all in suite" })

		vim.keymap.set("n", "<leader>tn", function()
			neotest.run.run()
		end, { desc = "[NeoTest] Test nearest" })

		vim.keymap.set("n", "<leader>tl", function()
			neotest.run.run_last()
		end, { desc = "[NeoTest] Test latest" })

		vim.keymap.set("n", "<leader>to", function()
			neotest.output.open()
		end, { desc = "[NeoTest] Open test output" })

		vim.keymap.set("n", "<leader>tp", function()
			neotest.output_panel.toggle()
		end, { desc = "[NeoTest] Toggle test output panel" })

		vim.keymap.set("n", "<leader>ts", function()
			neotest.summary.toggle()
		end, { desc = "[NeoTest] Toggle test summary" })

		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "[NeoTest] Debug test" })
	end,
}
