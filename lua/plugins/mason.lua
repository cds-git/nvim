return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- used for installing formatters and linters automatically
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls",
				-- "omnisharp",
				"html",
				"cssls",
				"angularls",
                "eslint",
                "vtsls",
				"bashls",
				"yamlls",
				"jsonls",
                "marksman",
				"helm_ls",
                "dockerls",
				"docker_compose_language_service",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"prettierd", -- js/ts formatter
				"eslint_d", -- js/ts linter
				"netcoredbg", -- .net debug adaptor
				"shfmt", -- bash formatter
			},
		})
	end,
}
