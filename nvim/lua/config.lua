local M = {}
local nnoremap = require("keymap").nnoremap

local completion = require("cmp_nvim_lsp")
M.on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local key_mappings = {
    { "referencesProvider",     "n", "gr",        vim.lsp.buf.references },
    { "hoverProvider",          "n", "K",         vim.lsp.buf.hover },
    { "implementationProvider", "n", "gi",        vim.lsp.buf.implementation },
    { "definitionProvider",     "n", "gd",        vim.lsp.buf.definition },
    { "signatureHelpProvider",  "i", "<c-space>", vim.lsp.buf.signature_help },
    {
      "workspaceSymbolProvider",
      "n",
      "gW",
      vim.lsp.buf.workspace_symbol,
    },
    {
      "codeActionProvider",
      "n",
      "<leader>r",
      vim.lsp.buf.code_action,
    },
    { "codeLensProvider", "n", "<leader>gr", vim.lsp.codelens.refresh },
    { "codeLensProvider", "n", "<leader>ge", vim.lsp.codelens.run },
  }

  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- if client.name == "svelte" then
  --   client.server_capabilities.documentFormattingProvider = false
  -- end

  if client.name == "clangd" then
    nnoremap("<c-h>", "<CMD>ClangdSwitchSourceHeader<CR>", bufopts)
  end

  nnoremap("grr", vim.lsp.buf.rename, bufopts)
  nnoremap(
    "<leader>f",
    function() vim.lsp.buf.format({ async = true }) end,
    bufopts
  )
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
        border = "rounded",
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

local util = require("lspconfig.util")

M.servers = {
  { "html",     { "vscode-html-language-server", "--stdio" } },
  { "jsonls",   { "vscode-json-language-server", "--stdio" } },
  { "svelte",   { "svelteserver", "--stdio" },               { "svelte" } },
  { "cssls",    { "vscode-css-language-server", "--stdio" } },
  { "omnisharp" },
  {
    "clangd",
    { "clangd" },
    { "c",     "cpp", "h", "hpp" },
  },
  { "bashls", { "bash-language-server", "start" } },
  {
    "rust_analyzer",
    { "rust-analyzer" },
    { "rust" },
    {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  {
    "prismals",
    { "prisma-language-server", "--stdio" },
    { "prisma" },
  },
  {
    "tailwindcss",
    { "tailwindcss-language-server", "--stdio" },
    {
      "javascriptreact",
      "javascript.jsx",
      "typescriptreact",
      "typescript.tsx",
      "html",
      "svelte",
    },
  },
  {
    "gopls",
    { "gopls" },
    { "go",   "gomod", "gowork", "gotmpl" },
  },
  {
    "pylsp",
    { "pylsp" },
    { "python" },
    {
      pylsp = {
        configurationSources = "flake8",
        plugins = {
          jedi_completion = { eager = true, fuzzy = true },
          rope_completion = {
            enable = true,
            eager = true,
          },
          ruff = {
            enabled = true,
            format = {
              "I",
              "COM",
              "F",
              "E",
              "B",
              "C4",
              "PIE",
              "Q",
              "RET",
              "SIM",
              "PERF",
            },
            select = {
              "I",
              "E",
              "F",
              "B",
              "Q",
              "ANN",
              "W",
              "C90",
              "N",
              "S",
              "A",
              "COM",
              "C4",
              "SIM",
              "ARG",
              "TID",
              "PTH",
              "PLE",
              "PLR",
              "TRY",
              "RUF",
              "ASYNC",
              "FBT",
              "PIE",
              "RET",
              "PERF",
            },
            unfixable = "B",
            ignore = {
              "ANN101",
              "ANN001",
              "ANN201",
              "ANN204",
            },
          },
          black = {
            enabled = true,
            line_length = 100,
            cache_config = true,
          },
        },
      },
    },
    function(fname)
      local root_files = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
      }

      return util.root_pattern(unpack(root_files))(fname)
          or util.find_git_ancestor(fname)
          or vim.fn.expand("%:p:h")
    end,
  },
  {
    "sqlls",
    { "sqlls" },
    { "sql",  "mysql", "psql" },
  },
  {
    "lua_ls",
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
