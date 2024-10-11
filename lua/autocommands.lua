vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
	pattern = { "*.props" },
	callback = function()
		vim.bo.filetype = "xml"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
	pattern = { "*.component.html" },
	callback = function()
		vim.bo.filetype = "angular"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
	pattern = { "*.json" },
	callback = function()
		vim.bo.filetype = "jsonc"
	end,
})
