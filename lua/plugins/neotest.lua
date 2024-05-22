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
			},
			-- icons = {
			-- 	expanded = "",
			-- 	child_prefix = "",
			-- 	child_indent = "",
			-- 	final_child_prefix = "",
			-- 	non_collapsible = "",
			-- 	collapsed = "",
			--
			-- 	passed = "",
			-- 	running = "",
			-- 	failed = "",
			-- 	unknown = "",
			-- 	running_animated = { "◴", "◷", "◶", "◵" },
			-- },
			adapters = {
				require("neotest-dotnet"),
			},
		})

		vim.keymap.set(
			"n",
			"<leader>tt",
			"<cmd>w<CR><cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
			{ desc = "[NeoTest] Test file" }
		)
		vim.keymap.set(
			"n",
			"<leader>ta",
			"<cmd>w<CR><cmd>lua require('neotest').run.run({ suite = true })<CR>",
			{ desc = "[NeoTest] Test suite" }
		)
		vim.keymap.set(
			"n",
			"<leader>tn",
			"<cmd>w<CR><cmd>lua require('neotest').run.run()<CR>",
			{ desc = "[NeoTest] Test nearest" }
		)
		vim.keymap.set(
			"n",
			"<leader>tl",
			"<cmd>w<CR><cmd>lua require('neotest').run.run_last()<CR>",
			{ desc = "[NeoTest] Test latest" }
		)
		vim.keymap.set(
			"n",
			"<leader>to",
			"<cmd>w<CR><cmd>lua require('neotest').output.open()<CR>",
			{ desc = "[NeoTest] Open test output" }
		)
		vim.keymap.set(
			"n",
			"<leader>tp",
			"<cmd>w<CR><cmd>lua require('neotest').output_panel.toggle()<CR>",
			{ desc = "[NeoTest] Toggle test output panel" }
		)
		vim.keymap.set(
			"n",
			"<leader>ts",
			"<cmd>w<CR><cmd>lua require('neotest').summary.toggle()<CR>",
			{ desc = "[NeoTest] Toggle test summary" }
		)
		vim.keymap.set("n", "<leader>td", function()
			vim.cmd("w")
			require("neotest").run.run({ strategy = "dap" })
		end, { desc = "[NeoTest] Debug test" })
	end,
}
