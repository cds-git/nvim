local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = "",
					section_separators = "",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
				},
				sections = {
					lualine_a = { { "mode", icon = "" } },
					lualine_b = {
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", file_status = true, padding = { left = 0, right = 1 } },
					},
					lualine_c = {
						{
							"branch",
							-- fmt = function(str)
							-- 	return string.sub(str, 1, 20)
							-- end,
						},
						{
							"diff",
							-- symbols = { added = " ", modified = " ", removed = " " },
							symbols = { added = "+", modified = "~", removed = "-" },
							diff_color = {
								added = { fg = colors.green },
								modified = { fg = colors.orange },
								removed = { fg = colors.red },
							},
							cond = conditions.hide_in_width,
						},
					},
					lualine_x = {
						-- {
						-- 	-- Lsp server name .
						-- 	function()
						-- 		local msg = "No Active Lsp"
						-- 		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
						-- 		local clients = vim.lsp.get_active_clients()
						-- 		if next(clients) == nil then
						-- 			return msg
						-- 		end
						-- 		for _, client in ipairs(clients) do
						-- 			local filetypes = client.config.filetypes
						-- 			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						-- 				return client.name
						-- 			end
						-- 		end
						-- 		return msg
						-- 	end,
						-- 	icon = " LSP:",
						-- 	color = { fg = "#ffffff", gui = "bold" },
						-- },
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = "" },
							diagnostics_color = {
								color_error = { fg = colors.red },
								color_warn = { fg = colors.yellow },
								color_info = { fg = colors.cyan },
							},
						},
					},
					lualine_y = {
						"grapple",
					},
					lualine_z = {
						"location",
					},
				},
			})
		end,
	},
}
