return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[Telescope] Find files in cwd" })
			vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "[Telescope] Find string in cwd" })
			vim.keymap.set(
				"n",
				"<leader>fw",
				builtin.grep_string,
				{ desc = "[Telescope] Find word under cursor in cwd" }
			)
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[Telescope] Find recent files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[Telescope] Find open buffer" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[Telescope] Help page" })
			vim.keymap.set("n", "<leader>fM", builtin.marks, { desc = "[Telescope] Find marks" })
			vim.keymap.set(
				"n",
				"<leader>fz",
				builtin.current_buffer_fuzzy_find,
				{ desc = "[Telescope] Fuzzy find in current buffer" }
			)
			vim.keymap.set("n", "<leader>fa", function()
				builtin.find_files({ follow = true, no_ignore = true, hidden = true })
			end, { desc = "[Telescope] Fuzzy find ALL files in cwd" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
