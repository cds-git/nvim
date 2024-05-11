return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				markdown = { "vale" },
				sh = { "shfmt" },
				javascript = { "eslint_d", "prettierd" },
				typescript = { "eslint_d", "prettierd" },
				angular = { "prettierd" },
				json = { "prettierd" },
				html = { "prettierd" },
				scss = { "prettierd" },
				css = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
		},
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)

			vim.keymap.set("n", "<leader>fm", function()
				conform.format({ async = true, lsp_fallback = true })
			end, { desc = "format files" })
		end,
	},
}
