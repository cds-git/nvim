return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame_opts = {
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 0,
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				vim.keymap.set("n", "]h", gitsigns.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
				vim.keymap.set("n", "[h", gitsigns.prev_hunk, { buffer = bufnr, desc = "Prev Hunk" })

				vim.keymap.set("n", "<leader>gB", function()
					gitsigns.blame_line({ full = true })
				end, { buffer = bufnr, desc = "[Gitsigns] Blame details" })

				vim.keymap.set("n", "<leader>gb", function()
					gitsigns.toggle_current_line_blame()
				end, { buffer = bufnr, desc = "[Gitsigns] Toggle blame line" })

				vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[Gitsigns] Preview git hunk" })
			end,
		},
	},
}
