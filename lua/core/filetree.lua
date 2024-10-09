return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			vim.keymap.set(
				"n",
				"<leader>e",
				"<cmd>Neotree filesystem reveal left<CR>",
				{ desc = "Go to current buffer in NeoTree explorer" }
			)
			vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree explorer" })
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			columns = {
				"icon",
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
			-- use_default_keymaps = false,
			keymaps = {
				["<C-h>"] = false,
				["<C-s>"] = false,
				["<C-l>"] = false,
				["<leader>sk"] = "actions.select_split",
				["<leader>sh"] = "actions.select_vsplit",
				["<leader>ro"] = "actions.refresh",
			},
		},
		config = function(_, opts)
			require("oil").setup(opts)

			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "[Oil] Open parent directory" })
		end,
	},
}
