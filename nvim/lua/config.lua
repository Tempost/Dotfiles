local M = {}
local nnoremap = require("keymap").nnoremap

local completion = require("cmp_nvim_lsp")
M.on_attach = function(client, bufnr)
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	local key_mappings = {
		{ "referencesProvider", "n", "gr", vim.lsp.buf.references },
		{ "hoverProvider", "n", "K", vim.lsp.buf.hover },
		{ "implementationProvider", "n", "gi", vim.lsp.buf.implementation },
		{ "signatureHelpProvider", "i", "<c-space>", vim.lsp.buf.signature_help },
		{ "workspaceSymbolProvider", "n", "gW", vim.lsp.buf.workspace_symbol },
		{ "codeActionProvider", { "n", "v" }, "<a-CR>", vim.lsp.buf.code_action },
		{
			"codeActionProvider",
			"n",
			"<leader>r",
			"<Cmd>lua vim.lsp.buf.code_action { context = { only = {'refactor'} }}<CR>",
		},
		{
			"codeActionProvider",
			"v",
			"<leader>r",
			"<Cmd>lua vim.lsp.buf.code_action { context = { only = {'refactor'} }}<CR>",
		},
		{ "codeLensProvider", "n", "<leader>gr", vim.lsp.codelens.refresh },
		{ "codeLensProvider", "n", "<leader>ge", vim.lsp.codelens.run },
	}

	nnoremap("grr", vim.lsp.buf.rename, bufopts)
	nnoremap("<leader>f", vim.lsp.buf.format, bufopts)

	for _, mappings in pairs(key_mappings) do
		local capability, mode, lhs, rhs = unpack(mappings)

		if client.server_capabilities[capability] then
			vim.keymap.set(mode, lhs, rhs, bufopts)
		end
	end
end

M.capabilities =
	vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), completion.default_capabilities())

M.lsp_flags = {
	debounce_text_changes = 80,
}
M.servers = {
	{ "html", { "vscode-html-language-server", "--stdio" } },
	{ "jsonls", { "vscode-json-language-server", "--stdio" } },
	{ "cssls", { "vscode-css-language-server", "--stdio" } },
	{ "clangd" },
	{ "bashls", { "bash-language-server", "start" } },
	{ "rust_analyzer", { "rust-analyzer" }, { "rust" } },
	{
		"tsserver",
		{ "typescript-language-server", "--stdio" },
		{ "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	},
	{ "prismals", { "prisma-language-server", "--stdio" }, { "prisma" } },
	{
		"tailwindcss",
		{ "tailwindcss-language-server", "--stdio" },
		{ "javascriptreact", "javascript.jsx", "typescriptreact", "typescript.tsx" },
	},
	{ "gopls", { "gopls" }, { ".go" } },
	{
		"sumneko_lua",
		{ "lua-language-server" },
		{ "lua" },
		{
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
}

return M
