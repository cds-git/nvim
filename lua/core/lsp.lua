vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local map = function(modes, keys, func, desc)
			vim.keymap.set(modes, keys, func, { buffer = ev.buf, desc = desc })
		end

		local telescope = require("telescope.builtin")

		-- Navigation
		-- map("n", "gd", vim.lsp.buf.definition, "Go to LSP definitions")
		-- map("n", "gi", vim.lsp.buf.implementation, "Go to LSP implementations")
        map("n", "gr", vim.lsp.buf.references, "Show LSP references")
		map("n", "gi", telescope.lsp_implementations, "Go to LSP implementations")
		map("n", "gd", telescope.lsp_definitions, "Show LSP definitions")
		-- map("n", "gr", telescope.lsp_references, "Show LSP references")

		-- map("n", "gD", vim.lsp.buf.type_definition, "Go to declaration")
		map("n", "gD", vim.lsp.buf.declaration, "Go to LSP declaration")
		map("n", "gt", telescope.lsp_type_definitions, "Go to LSP type definitions")

		-- Diagnostics and documentations
		map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
		map("n", "<leader>lf", vim.diagnostic.open_float, "Show line diagnostics")
		map("n", "<leader>sh", vim.lsp.buf.signature_help, "Show signature help")
		map("i", "<c-k>", vim.lsp.buf.signature_help, "Show signature Help")
		map("n", "<leader>ds", telescope.lsp_document_symbols, "Document symbols")

		map("n", "<leader>ld", function()
			telescope.diagnostics({ bufnr = 0 })
		end, "Show buffer diagnostics")

		-- LSP actions
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
		map("n", "<leader>rn", vim.lsp.buf.rename, "[LSP] Rename")

		map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")

		-- workspace
		map("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, "Workspace symbols")
		map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
		map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "List workspace folders")

		map("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, "Toggle inlay hints")
	end,
})

vim.diagnostic.config({
	-- virtual_text = { spacing = 4, prefix = "● " },
	virtual_text = false,
	float = { border = "rounded", source = "if_many", focusable = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
})

return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			return vim.tbl_extend("force", opts, {
				servers = {
					lua_ls = { before_init = require("lazydev.lsp").before_init },
				},
			})
		end,
		config = function(_, opts)
			require("mason-lspconfig").setup_handlers({
				function(server)
					local server_status_ok, server_config = pcall(require, "langs." .. server)
					if not server_status_ok then
						server_config = {}
					end

					local config = vim.tbl_deep_extend("force", {
						capabilities = require("utility.capabilities").capabilities,
						on_attach = require("utility.on_attach").on_attach,
					}, server_config)
					require("lspconfig")[server].setup(config)
				end,
			})
		end,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "williamboman/mason.nvim", config = true, cmd = "Mason" },
			{ "williamboman/mason-lspconfig.nvim", config = true, cmd = { "LspInstall", "LspUninstall" } },
			{ "Issafalcon/lsp-overloads.nvim", event = "BufReadPre" },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
            -- enables omnisharp goto definition with decompliation
            { "Hoffs/omnisharp-extended-lsp.nvim", enabled = true, lazy = true },
			-- { "seblj/nvim-lsp-extras" },
			{ -- Roslyn LSP for C#/.NET instead of omnisharp
				"seblj/roslyn.nvim",
				enabled = false,
				ft = "cs",
				config = function()
					require("roslyn").setup({
						config = {
							capabilities = require("utility.capabilities").capabilities,
							on_attach = require("utility.on_attach").on_attach,
						},
					})
				end,
			},
		},
	},
}
