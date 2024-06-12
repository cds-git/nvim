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
		{
			"Issafalcon/lsp-overloads.nvim",
			event = "BufReadPre",
		},
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
				map("n", "gr", vim.lsp.buf.references, "Show LSP references")
				-- map("n", "gd", vim.lsp.buf.definition, "Go to LSP definitions")
				-- map("n", "gi", vim.lsp.buf.implementation, "Go to LSP implementations")
				map("n", "gi", telescope.lsp_implementations, "Go to LSP implementations")
				map("n", "gd", telescope.lsp_definitions, "Show LSP definitions")
				-- map("n", "gr", telescope.lsp_references, "Show LSP references")

				-- map("n", "gD", vim.lsp.buf.type_definition, "Go to declaration")
				map("n", "gD", vim.lsp.buf.declaration, "Go to LSP declaration")
				map("n", "gt", telescope.lsp_type_definitions, "Go to LSP type definitions")

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
				map("n", "<leader>rn", vim.lsp.buf.rename, "[LSP] Rename")

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

		-- Global diagnostic settings
		vim.diagnostic.config({
			virtual_text = false,
			severity_sort = true,
			update_in_insert = false,
			float = {
				header = "",
				source = "always",
				border = "rounded",
				focusable = true,
			},
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
						if client.server_capabilities.signatureHelpProvider then
							require("lsp-overloads").setup(client, {
								-- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
								ui = {
									border = "rounded", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
									height = nil, -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
									width = nil, -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
									wrap = true, -- Wrap long lines
									wrap_at = nil, -- Character to wrap at for computing height when wrap enabled
									max_width = nil, -- Maximum signature popup width
									max_height = nil, -- Maximum signature popup height
									-- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
									close_events = { "CursorMoved", "CursorMovedI", "InsertCharPre" },
									focusable = true, -- Make the popup float focusable
									focus = false, -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
									offset_x = 0, -- Horizontal offset of the floating window relative to the cursor position
									offset_y = 0, -- Vertical offset of the floating window relative to the cursor position
									floating_window_above_cur_line = true, -- Attempt to float the popup above the cursor position
									-- (note, if the height of the float would be greater than the space left above the cursor, it will default
									-- to placing the float below the cursor. The max_height option allows for finer tuning of this)
									silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
									-- Highlight options is null by default, but this just shows an example of how it can be used to modify the LspSignatureActiveParameter highlight property
									highlight = {
										italic = true,
										bold = true,
										fg = "#ffffff",
									},
								},
								keymaps = {
									next_signature = "<C-j>",
									previous_signature = "<C-k>",
									next_parameter = "<C-l>",
									previous_parameter = "<C-h>",
									close_signature = "<A-s>",
								},
								display_automatically = true, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
							})
						end
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
