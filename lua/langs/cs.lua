return {
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "c_sharp" })
			end
		end,
	},

	-- LSP + code actions
	{
		"seblj/roslyn.nvim",
		ft = "cs",
		config = function()
			require("roslyn").setup({
				config = {
					on_attach = require("utility.on_attach").on_attach,
				},
			})
		end,
		dependencies = {
			{ "Issafalcon/lsp-overloads.nvim", event = "BufReadPre" },
			{ "seblj/nvim-lsp-extras" },
		},
	},
}
