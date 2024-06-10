return {
	{
		-- Telescope UI override for vim.ui.input and vim.ui.select
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{ -- DISABLED - REASON IT OVERRIDES TOO MANY DAMN THINGS, I JUST WANT THE CMDLINE AND SEARCH FLOATS
		"folke/noice.nvim",
		enabled = false,
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			-- routes = {
			-- 	{
			-- 		opts = { skip = true },
			-- 		filter = {
			-- 			event = "msg_show",
			-- 			any = {
			-- 				-- skip search messages
			-- 				{ find = "search hit" },
			--
			-- 				-- skip undo messages
			-- 				{ find = "%d+ line less" },
			-- 				{ find = "%d+ fewer lines" },
			-- 				{ find = "%d+ more line" },
			-- 				{ find = "%d+ change" },
			-- 			},
			-- 		},
			-- 	},
			-- 	{
			-- 		view = "mini",
			-- 		filter = {
			-- 			event = "msg_show",
			-- 			any = {
			-- 				-- mini write messages "{n}L, {n}B"
			-- 				{ find = "%d+L, %d+B" },
			--
			-- 				-- mini search messages
			-- 				{ find = "Pattern not found" },
			-- 			},
			-- 		},
			-- 	},
			-- },
		},
	},
}
