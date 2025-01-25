return {
	"nvim-telescope/telescope.nvim",
	enabled = false,
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
				prompt_prefix = "   ",
				-- selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",
				layout_config = { prompt_position = "top", height = 0.88 },
				layout_strategy = "vertical",
				file_ignore_patterns = { "node_modules", "package%-lock.json" },
				path_display = { "filename_first", "truncate" },
			},
			pickers = {
				find_files = {
					previewer = false,
					layout_config = {
						width = 0.55,
						height = 0.60,
					},
				},
				oldfiles = {
					previewer = false,
					layout_config = {
						width = 0.55,
						height = 0.60,
					},
				},
				live_grep = {
					only_sort_text = true,
				},
				grep_string = {
					only_sort_text = true,
				},
				buffers = {
					hidden = true,
					show_all_buffers = true,
					sort_lastused = true,
				},
				-- diagnostics = {
				-- 	layout_config = { prompt_position = "top", height = 0.88 },
				-- 	layout_strategy = "vertical",
				-- },
				lsp_document_symbols = {
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
					},
				},
				lsp_dynamic_workspace_symbols = {
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("grapple")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[Telescope] Find files in cwd" })
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "[Telescope] Find string in cwd" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[Telescope] Find word under cursor in cwd" })
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

		vim.keymap.set("n", "<leader>fy", builtin.registers, { desc = "[Telescope] Find in registers" })
		vim.keymap.set("n", "<leader>fc", builtin.spell_suggest, { desc = "[Telescope] Spell suggest" })
	end,
}
