return {
	{
		"williamboman/mason.nvim",
		--lazy = false,
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"eslint_d",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		--lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = {
				"lua_ls",
				"html",
				"cssls",
				"angularls",
				"tsserver",
				"omnisharp",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		--lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
			lspconfig.angularls.setup({
				capabilities = capabilities,
			})
			lspconfig.omnisharp.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
