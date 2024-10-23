return {
	"nvim-neotest/neotest",
	enabled = false,
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",
        "nvim-neotest/neotest-plenary",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"Issafalcon/neotest-dotnet",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-plenary"),
				require("neotest-dotnet")({
					discovery_root = "solution",
				}),
			},
			log_level = 1, -- For verbose logs
			icons = {
				expanded = "",
				child_prefix = "",
				child_indent = "",
				final_child_prefix = "",
				non_collapsible = "",
				collapsed = "",
				passed = "",
				running = "",
				failed = "",
				unknown = "",
				skipped = "",
			},
		})

		local neotest = require("neotest")

		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "[NeoTest] Test file" })

		vim.keymap.set("n", "<leader>ta", function()
			neotest.run.run({ suite = true })
		end, { desc = "[NeoTest] Test all in suite" })

		vim.keymap.set("n", "<leader>tr", function()
			neotest.run.run()
		end, { desc = "[NeoTest] Test run nearest" })

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
			neotest.run.run({ strategy = "dap", suite = false })
		end, { desc = "[NeoTest] Debug test" })
	end,
}
