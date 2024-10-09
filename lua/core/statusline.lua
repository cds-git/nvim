-- TODO: Get colors from a theme colorscheme
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
						"grapple",
					},
					lualine_c = {
						{
							-- Lsp server name .
							function()
								local clients = vim.lsp.get_clients()

								if next(clients) == nil then
									return ""
								end

								return " "

								-- local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
								-- local c = {}
								--
								-- for _, client in ipairs(clients) do
								-- 	local filetypes = client.config.filetypes
								-- 	if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								-- 		if client.name == "omnisharp" then
								-- 			table.insert(c, "󰈸")
								-- 		elseif client.name == "angularls" then
								-- 			table.insert(c, "")
								-- 		elseif client.name == "tsserver" then
								-- 			table.insert(c, "")
								-- 		elseif client.name == "html" then
								-- 			table.insert(c, "")
								-- 		elseif client.name == "cssls" then
								-- 			table.insert(c, "")
								-- 		else
								-- 			table.insert(c, client.name)
								-- 		end
								-- 	end
								-- end
								--
								-- return table.concat(c, "|")
							end,
							-- icon = " ",
							-- color = { fg = "#ffffff", gui = "bold" },
						},
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
					lualine_x = {
						{
							"diff",
							-- symbols = { added = " ", modified = " ", removed = " " },
							symbols = { added = "+", modified = "~", removed = "-" },
							diff_color = {
								added = { fg = colors.green },
								modified = { fg = colors.orange },
								removed = { fg = colors.red },
							},
						},
						{
							"branch",
							fmt = function(str)
								if string.len(str) <= 32 then
									return str
								end
								return string.sub(str, 1, 32) .. "..."
							end,
						},
					},
					lualine_y = {
						"location",
					},
					lualine_z = {
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", file_status = true, padding = { left = 0, right = 1 } },
					},
				},
			})
		end,
	},
}
