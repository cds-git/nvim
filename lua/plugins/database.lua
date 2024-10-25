return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.keymap.set("n", "<leader>Du", "<CMD>DBUIToggle<CR>", { desc = "[Dadbod] Toggle" })
		vim.keymap.set("n", "<leader>Df", "<CMD>DBUIFindBuffer<CR>", { desc = "[Dadbod] Find Buffer" })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sql",
			callback = function(event)
				require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
			end,
		})
	end,
}
