vim.api.nvim_create_user_command("MasonInstallAll", function()
	local packages = {
		-- Language servers
		"lua-language-server",
		"roslyn",
		"html-lsp",
		"css-lsp",
		"angular-language-server",
		"eslint-lsp",
		"vtsls",
		"bash-language-server",
		"yaml-language-server",
		"json-lsp",
		"marksman",
		"helm-ls",
		"dockerfile-language-server",
		"docker-compose-language-service",
		-- formatters
		"stylua",
		"prettierd",
		"shfmt",
		-- debuggers
		"netcoredbg",
		-- linters
		"eslint_d",
		"shellcheck",
	}

	for _, package in ipairs(packages) do
		local installPackage = "MasonInstall " .. package
		-- print(installPackage)
		vim.cmd(installPackage)
	end
end, { desc = "Install all Mason packages" })
