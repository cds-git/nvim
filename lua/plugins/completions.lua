return {
	"hrsh7th/nvim-cmp",
	--event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			-- completion = {
			-- 	completeopt = "menu,menuone,preview,noselect",
			-- },
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = {
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- select = if first item should be selected by default
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", "n" }), -- show completion suggestions
				["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s", "c" }), -- previous suggestion
				["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" }), -- next suggestion
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					else
						fallback()
					end
				end, { "i", "s", "c" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					else
						fallback()
					end
				end, { "i", "s", "c" }),
			},

			performance = {
				max_view_entries = 100,
			},
			-- sources for autocompletion
			sources = cmp.config.sources({
				{
					-- lsp
					name = "nvim_lsp",
					priority = 10,
				},
				{
					-- snippets
					name = "luasnip",
					priority = 7,
					max_item_count = 5,
				},
				{
					-- text within current buffer
					name = "buffer",
					priority = 7,
					max_item_count = 5,
				},
				{
					-- file system paths
					name = "path",
					priority = 5,
					max_item_count = 10,
				},
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				fields = { "abbr", "kind", "menu" },
				expandable_indicator = true,
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
