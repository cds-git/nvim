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

		-- Navigation
		map("n", "gr", vim.lsp.buf.references, "Show LSP references")
		-- map("n", "gd", vim.lsp.buf.definition, "Go to LSP definitions")
		-- map("n", "gi", vim.lsp.buf.implementation, "Go to LSP implementations")
		map("n", "gD", vim.lsp.buf.declaration, "Go to LSP declaration")
		-- map("n", "gD", vim.lsp.buf.type_definition, "Go to declaration")

		-- Diagnostics and documentations
		map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
		map("n", "<leader>lf", vim.diagnostic.open_float, "Show line diagnostics")
		map("n", "<leader>sh", vim.lsp.buf.signature_help, "Show signature help")
		map("i", "<c-k>", vim.lsp.buf.signature_help, "Show signature Help")

		-- LSP actions
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
		map("n", "<leader>rn", vim.lsp.buf.rename, "[LSP] Rename")
		map("n", "<leader>rS", ":LspRestart<CR>", "Restart LSP")
		map("n", "<leader>rs", ":Roslyn restart<CR>", "Restart Roslyn LSP")
		map("n", "<leader>rt", ":Roslyn target<CR>", "Select solution file with Roslyn LSP")

		-- workspace
		map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
		map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "List workspace folders")

		vim.lsp.handlers["textDocument/hover"] =
			vim.lsp.with(vim.lsp.handlers["textDocument/hover"], { border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
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
		-- opts = function(_, opts)
		--     return vim.tbl_extend("force", opts, {
		--         servers = {
		--             lua_ls = { before_init = require("lazydev.lsp").before_init },
		--         },
		--     })
		-- end,
		-- config = function(_, opts)
		--     require("mason-lspconfig").setup_handlers({
		--         function(server)
		--             local server_status_ok, server_config = pcall(require, "langs." .. server)
		--             if not server_status_ok then
		--                 server_config = {}
		--             end
		--
		--             local config = vim.tbl_deep_extend("force", {
		--                 capabilities = require("utility.capabilities").capabilities,
		--                 on_attach = require("utility.on_attach").on_attach,
		--             }, server_config)
		--             require("lspconfig")[server].setup(config)
		--         end,
		--     })
		-- end,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "saghen/blink.cmp" },
			{
				"mason-org/mason.nvim",
				opts = {
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				},
			},
			-- { "mason-org/mason-lspconfig.nvim", config = true,       cmd = { "LspInstall", "LspUninstall" } },
			{ "Issafalcon/lsp-overloads.nvim", event = "BufReadPre" },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				dependencies = {
					{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
				},
				opts = {
					library = {
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ -- Roslyn LSP for C#/.NET instead of omnisharp
				"seblj/roslyn.nvim",
				enabled = true,
				config = function()
				    require("roslyn").setup({
				        config = {
				            capabilities = require("utility.capabilities").capabilities,
				            on_attach = require("utility.on_attach").on_attach,
				            settings = {
				                ["csharp|background_analysis"] = {
				                    dotnet_compiler_diagnostics_scope = "fullSolution",
				                },
				                ["csharp|inlay_hints"] = {
				                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
				                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
				                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
				                    csharp_enable_inlay_hints_for_types = true,
				                    dotnet_enable_inlay_hints_for_indexer_parameters = true,
				                    dotnet_enable_inlay_hints_for_literal_parameters = true,
				                    dotnet_enable_inlay_hints_for_object_creation_parameters = true,
				                    dotnet_enable_inlay_hints_for_other_parameters = true,
				                    dotnet_enable_inlay_hints_for_parameters = true,
				                    dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
				                    dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
				                    dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
				                },
				                ["csharp|code_lens"] = {
				                    dotnet_enable_references_code_lens = true,
				                },
				            },
				        },
				    })
				end,
			},
		},
	},
}
