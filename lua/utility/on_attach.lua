---@diagnostic disable: missing-fields
local M = {}

M.on_attach = function(client, bufnr)
	if client.server_capabilities.signatureHelpProvider then
		local lsp_overloads_ok, lsp_overloads = pcall(require, "lsp-overloads")
		if lsp_overloads_ok then
			lsp_overloads.setup(client, {
				-- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
				ui = {
					border = "rounded", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
					floating_window_above_cur_line = true, -- Attempt to float the popup above the cursor position
					-- (note, if the height of the float would be greater than the space left above the cursor, it will default
					-- to placing the float below the cursor. The max_height option allows for finer tuning of this)
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
	end
end

return M
