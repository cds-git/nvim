return {
	"saghen/blink.cmp",
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
		{
			"saghen/blink.compat",
			version = "*",
		},
	},
	version = "*",
	event = { "InsertEnter", "CmdlineEnter" },
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "normal",
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				update_delay_ms = 50,
				treesitter_highlighting = true,
				window = { border = "rounded" },
			},
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
					treesitter = { "lsp" },
				},
			},
			ghost_text = { enabled = true },
		},
		-- Experimental signature help support
		signature = {
			enabled = false,
			window = { border = "rounded" },
		},
		-- My super-TAB configuration
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = {
				function(cmp)
					return cmp.select_next()
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = {
				function(cmp)
					return cmp.select_prev()
				end,
				"snippet_backward",
				"fallback",
			},
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-up>"] = { "scroll_documentation_up", "fallback" },
			["<C-down>"] = { "scroll_documentation_down", "fallback" },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			cmdline = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Commands
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		},
	},
}
