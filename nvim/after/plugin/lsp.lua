require("mason").setup({
  ui = {
    border = "single",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "sumneko_lua",
    "tsserver",
    "cssls",
    "jsonls",
    "html",
    "rust_analyzer",
    "prismals",
    "bashls",
    "sqls",
    "tailwindcss",
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "single" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
  border = "single",
})

local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap

local completion = require("cmp_nvim_lsp")
local on_attach = function(client, bufnr)
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local key_mappings = {
    { "referencesProvider", "n", "gr", vim.lsp.buf.references },
    { "hoverProvider", "n", "K", vim.lsp.buf.hover },
    { "implementationProvider", "n", "gi", vim.lsp.buf.implementation },
    { "signatureHelpProvider", "i", "<c-space>", vim.lsp.buf.signature_help },
    { "workspaceSymbolProvider", "n", "gW", vim.lsp.buf.workspace_symbol },
    { "codeActionProvider", { "n", "v" }, "<a-CR>", vim.lsp.buf.code_action },
    { "codeActionProvider", "n", "<leader>r",
      "<Cmd>lua vim.lsp.buf.code_action { context = { only = {'refactor'} }}<CR>" },
    { "codeActionProvider", "v", "<leader>r",
      "<Cmd>lua vim.lsp.buf.code_action { context = { only = {'refactor'} }}<CR>" },
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

local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  completion.default_capabilities()
)

local lsp_flags = {
  debounce_text_changes = 80,
}

local nvim_lsp = require("lspconfig")
nvim_lsp.tsserver.setup({
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  flags = lsp_flags,
})

nvim_lsp.prismals.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetype = { "prisma" },
  flags = lsp_flags,
})

nvim_lsp.tailwindcss.setup({
  cmd = { "tailwindcss-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascriptreact", "javascript.jsx", "typescriptreact", "typescript.tsx" },
  flags = lsp_flags,
})

nvim_lsp.cssls.setup({
  cmd = { "vscode-css-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "css", "scss" },
  flags = lsp_flags,
})

nvim_lsp.jsonls.setup({
  cmd = { "vscode-json-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetype = { "json" },
  flags = lsp_flags,
})

nvim_lsp.clangd.setup({
  cmd = { "clangd" },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
})

nvim_lsp.rust_analyzer.setup({
  cmd = { "rust-analyzer" },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
})

nvim_lsp.gopls.setup({
  capabilities = capabilities,
  cmd = { "gopls" },
  on_attach = on_attach,
  flags = lsp_flags,
})

nvim_lsp.html.setup({
  cmd = { "vscode-html-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
})

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
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
})

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    formatting.prettierd,
    diagnostics.eslint_d
  },
})

require("fidget").setup({
  text = {
    spinner = "dots", -- animation shown when tasks are ongoing
    done = "", -- character shown when all tasks are complete
    commenced = "Started", -- message shown when task starts
    completed = "Completed", -- message shown when task completes
  },
  align = {
    bottom = true, -- align fidgets along bottom edge of buffer
    right = true, -- align fidgets along right edge of buffer
  },
  timer = {
    spinner_rate = 125, -- frame rate of spinner animation, in ms
    fidget_decay = 2000, -- how long to keep around empty fidget, in ms
    task_decay = 1000, -- how long to keep around completed task, in ms
  },
  window = {
    relative = "editor", -- where to anchor, either 'win' or 'editor'
    blend = 0, -- &winblend for the window
    zindex = nil, -- the zindex value for the window
  },
  fmt = {
    leftpad = true, -- right-justify text in fidget box
    stack_upwards = true, -- list of tasks grows upwards
    max_width = 0, -- maximum width of the fidget box
    -- function to format fidget title
    fidget = function(fidget_name, spinner)
      return string.format("%s %s", spinner, fidget_name)
    end,
    -- function to format each task line
    task = function(task_name, message, percentage)
      return string.format(
        "%s%s [%s]",
        message,
        percentage and string.format(" (%s%%)", percentage) or "",
        task_name
      )
    end,
  },
  debug = {
    logging = false, -- whether to enable logging, for debugging
  },
})
