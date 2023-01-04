local M = {}
local nnoremap = require("keymap").nnoremap

local completion = require("cmp_nvim_lsp")
M.on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local key_mappings = {
    { "referencesProvider", "n", "gr", vim.lsp.buf.references },
    { "hoverProvider", "n", "K", vim.lsp.buf.hover },
    { "implementationProvider", "n", "gi", vim.lsp.buf.implementation },
    { "definitionProvider", "n", "gd", vim.lsp.buf.definition },
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
  nnoremap("<leader>gf", vim.diagnostic.open_float, bufopts)
  nnoremap("<leader>gj", vim.diagnostic.goto_next, bufopts)
  nnoremap("<leader>gk", vim.diagnostic.goto_prev, bufopts)
  nnoremap("<leader>D", vim.lsp.buf.type_definition, bufopts)

  for _, mappings in pairs(key_mappings) do
    local capability, mode, lhs, rhs = unpack(mappings)

    if client.server_capabilities[capability] then
      vim.keymap.set(mode, lhs, rhs, bufopts)
    end
  end

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "single",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })

  if client.server_capabilities.documentHighlightProvider then
    local colors = require("gruvbox-baby.colors").config()
    vim.api.nvim_set_hl(
      0,
      "LspReferenceRead",
      { bg = colors.medium_gray, bold = true }
    )
    vim.api.nvim_set_hl(
      0,
      "LspReferenceText",
      { bg = colors.medium_gray, bold = true }
    )
    vim.api.nvim_set_hl(
      0,
      "LspReferenceWrite",
      { bg = colors.medium_gray, bold = true }
    )

    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })

    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  completion.default_capabilities()
)
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

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
  { "prismals", { "prisma-language-server", "--stdio" }, { "prisma" } },
  {
    "tailwindcss",
    { "tailwindcss-language-server", "--stdio" },
    {
      "javascriptreact",
      "javascript.jsx",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  { "gopls", { "gopls" }, { ".go" } },
  {
    "pylsp",
    { "pylsp" },
    { "python" },
    {
      pylsp = {
        plugins = {
          jedi_completion = { eager = true },
          rope_completion = {
            enable = true,
            eager = true,
          },
          ruff = {
            enabled = true,
            lineLength = 100,
          },
        },
      },
    },
  },
  {
    "sqls",
    { "sqls" },
    { "sql", "mysql", "psql" },
  },
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
