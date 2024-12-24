local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "ccls",
  "clangd",
  "bashls",
  "tailwindcss",
  "gopls",
  "rust_analyzer",
  "sqlls",
  "prismals",
  "jsonls",
  "spectral",
  "nginx_language_server",
}

require("neodev").setup()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = vim.keymap.set
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    if client.name == "ts_ls" then
      client.server_capabilities.documentFormattingProvider = false
    end

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.diagnostic.config {
      severity_sort = true,
      float = {
        style = "minimal",
        header = "",
        source = true,
        wrap_at = 80,
      },
    }

    map("n", "<leader>lf", function()
      vim.diagnostic.open_float { border = "rounded" }
    end, { desc = "Open float diagnostic menu" })
  end,
})

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
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

lspconfig.ts_ls.setup {
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

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

local enable_providers = {
  "python3_provider",
}

-- TODO: Move this to a util file
for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

vim.g.python3_host_prog = vim.fn.stdpath "data" .. "/virtualenvs/neovim/bin/python3.10"

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      configurationSources = "flake8",
      plugins = {
        jedi_completion = { eager = true, fuzzy = true },
        rope_completion = { enable = true, eager = true },
        ruff = {
          enabled = true,
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
          targetVersion = "py38",
          unfixable = "B",
          ignore = {
            "Q000",
            "ANN101",
            "ANN001",
            "ANN002",
            "ANN003",
            "ANN201",
            "ANN204",
            "S105",
          },
        },
      },
    },
  },
}
