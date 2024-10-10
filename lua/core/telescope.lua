return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			-- local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					-- prompt_prefix = " ",
					-- selection_caret = " ",
					path_display = { "smart" },

					-- wrap_results = true,
					layout_strategy = "vertical",
					layout_config = { prompt_position = "top", width = 0.5 },
					sorting_strategy = "ascending",
					-- winblend = 0,
				},
				pickers = {
					find_files = {
						-- theme = "dropdown",
						layout_strategy = "center",
						layout_config = {
							preview_cutoff = 9999,
						},
					},
					oldfiles = {
						layout_strategy = "center",
						layout_config = {
							preview_cutoff = 9999,
						},
					},
					-- diagnostics = {
					-- theme = "dropdown",
					-- initial_mode = "normal",
					-- layout_config = {
					-- 	preview_cutoff = 9999,
					-- },
					-- },
				},
				extensions = {
					-- Your extension configuration goes here:
					-- extension_name = {
					--   extension_config_key = value,
					-- }
					-- please take a look at the readme of the extension you want to configure
				},
			})

			telescope.load_extension("fzf")

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
}
