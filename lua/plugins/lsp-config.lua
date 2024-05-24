return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{
			"folke/neodev.nvim",
			opts = {
				library = { plugins = { "neotest" }, types = true },
			},
		},
		{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

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
				map("n", "gr", telescope.lsp_references, "Show LSP references")
				map("n", "gd", telescope.lsp_definitions, "Show LSP definitions")
				map("n", "gi", telescope.lsp_implementations, "Show LSP implementations")

				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gt", telescope.lsp_type_definitions, "Show LSP type definitions")

				map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
				map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")

				-- Diagnostics and documentations
				map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
				map("n", "<leader>lf", vim.diagnostic.open_float, "Show line diagnostics")
				map("n", "<leader>sh", vim.lsp.buf.signature_help, "Show signature help")
				map("n", "<leader>ds", telescope.lsp_document_symbols, "Document symbols")

				map("n", "<leader>ld", function()
					telescope.diagnostics({ bufnr = 0 })
				end, "Show buffer diagnostics")

				-- LSP actions
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")

				map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")

				-- workspace
				map("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, "Workspace symbols")
				map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
				map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
				map("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "List workspace folders")
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["omnisharp"] = function()
				-- configure omnisharp for C#/.NET
				lspconfig.omnisharp.setup({
					capabilities = capabilities,
					cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
					on_attach = function(client, bufnr)
						vim.keymap.set(
							"n",
							"gd",
							require("omnisharp_extended").telescope_lsp_definition,
							{ desc = "Show LSP definitions OmniSharp", remap = true, buffer = bufnr }
						)
					end,
					-- Enables support for reading code style, naming convention and analyzer
					-- settings from .editorconfig.
					enable_editorconfig_support = true,
					-- If true, MSBuild project system will only load projects for files that
					-- were opened in the editor. This setting is useful for big C# codebases
					-- and allows for faster initialization of code navigation features only
					-- for projects that are relevant to code that is being edited. With this
					-- setting enabled OmniSharp may load fewer projects and may thus display
					-- incomplete reference lists for symbols.
					enable_ms_build_load_projects_on_demand = false,
					-- Enables support for roslyn analyzers, code fixes and rulesets.
					enable_roslyn_analyzers = true,
					-- Specifies whether 'using' directives should be grouped and sorted during
					-- document formatting.
					organize_imports_on_format = true,
					-- Enables support for showing unimported types and unimported extension
					-- methods in completion lists. When committed, the appropriate using
					-- directive will be added at the top of the current file. This option can
					-- have a negative impact on initial completion responsiveness,
					-- particularly for the first few completion sessions after opening a
					-- solution.
					enable_import_completion = true,
					-- Specifies whether to include preview versions of the .NET SDK when
					-- determining which version to use for project loading.
					sdk_include_prereleases = true,
					-- Only run analyzers against open files when 'enableRoslynAnalyzers' is true
					analyze_open_documents_only = false,
				})
			end,
			["angularls"] = function()
				local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
				local angular_language_server_path = mason_packages
					.. "/angular-language-server/node_modules/.bin/ngserver"
				local typescript_language_server_path = mason_packages
					.. "/typescript-language-server/node_modules/.bin/tsserver"
				local node_modules_global_path = "./node_modules"

				local angular_cmd = {
					angular_language_server_path,
					"--stdio",
					"--tsProbeLocations",
					typescript_language_server_path,
					"--ngProbeLocations",
					node_modules_global_path,
					"--includeCompletionsWithSnippetText",
					"--includeAutomaticOptionalChainCompletions",
				}

				lspconfig.angularls.setup({
					capabilities = capabilities,
					cmd = angular_cmd,
					on_new_config = function(new_config, _)
						new_config.cmd = angular_cmd
					end,
					filetypes = { "angular", "typescript", "html", "typescriptreact", "typescript.tsx" },
					-- root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
					root_dir = function()
						return vim.fn.getcwd()
					end,
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
