local config = require "plugins.configs.lspconfig"
local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local servers = {
  "html",
  "ccls",
  "clangd",
  "jsonls",
  "bashls",
  "tailwindcss",
  "gopls",
  "rust_analyzer",
  "sqlls",
  "prismals"
}

local custom_on_attach = function(client, bufnr)
  on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = custom_on_attach,
    capabilities = capabilities,
  }
end

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
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
          line_length = 88,
          cache_config = true,
        },
      },
    },
  },
  root_dir = function(fname)
    local root_files = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
    }

    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or vim.fn.expand "%:p:h"
  end,
}
