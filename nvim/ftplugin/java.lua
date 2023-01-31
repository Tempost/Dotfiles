vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

local nnoremap = require("keymap").nnoremap
local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/cody/.local/share/eclipse/" .. project_name

-- some generic keybinds
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  nnoremap("K", vim.lsp.buf.hover, bufopts)
  nnoremap("gd", vim.lsp.buf.definition, bufopts) -- zero means current buffer
  nnoremap("gs", vim.lsp.buf.signature_help, bufopts)
  nnoremap("gi", vim.lsp.buf.implementation, bufopts)
  nnoremap("gr", vim.lsp.buf.references, bufopts)
  nnoremap("<leader>ga", vim.lsp.buf.code_action, bufopts)
  nnoremap("<leader>gf", vim.diagnostic.open_float, bufopts)
  nnoremap("<leader>gj", vim.diagnostic.goto_next, bufopts)
  nnoremap("<leader>gk", vim.diagnostic.goto_prev, bufopts)
  nnoremap("<leader>D", vim.lsp.buf.type_definition, bufopts)
  nnoremap("<leader>r", vim.lsp.buf.rename, bufopts)
  nnoremap("<A-o>", jdtls.organize_imports, bufopts)

  nnoremap("<leader>dn", jdtls.test_nearest_method, bufopts)
  vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)

  require("jdtls.setup").add_commands()
  require("jdtls").setup_dap({ hotcodreplace = "auto" })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {
  vim.fn.glob("/opt/java-debug/com.microsoft.java.debug.plugin-0.44.0.jar", 1),
}

vim.list_extend(
  bundles,
  vim.split(vim.fn.glob("/opt/vscode-java-test/*jar", 1), "\n")
)

local config = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" },
  },
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-noverify",
    "-Xmx4G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    "/opt/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration",
    "/opt/eclipse.jdt.ls/config_linux",
    "-data",
    workspace_dir,
  },
  on_attach = on_attach,
  capabilities = capabilities,
  extendedClientCapabilities = extendedClientCapabilities,
  root_dir = vim.fs.dirname(
    vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]
  ),
  init_options = {
    bundles = bundles,
  },
}

require("jdtls").start_or_attach(config)
