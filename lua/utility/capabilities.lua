local M = {}

--- The default M LSP capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- M.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
-- M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities.textDocument.completion.completionItem.preselectSupport = true
-- M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
-- M.capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = { "documentation", "detail", "additionalTextEdits" },
-- }

-- Add capabilities required for LSP based completions
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
	M.capabilities = vim.tbl_deep_extend("force", M.capabilities, cmp_nvim_lsp.default_capabilities())
end

return M
