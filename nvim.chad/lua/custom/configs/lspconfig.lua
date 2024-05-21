local config = require "plugins.configs.lspconfig"
local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

vim.g.python3_host_prog = "/home/cody/.local/share/virtualenvs/neovim/bin/python3.10"
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
  "prismals",
}
local my_on_attach = function(client, bufnr)
  on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = my_on_attach,
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

lspconfig.spectral.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()

lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    allow_incremental_sync = true,
  },
  settings = {
    java = {
      home = "user/lib/jvm/java-17-temurin",
      contentProvider = { preferred = "fernflower" },
      format = {
        enabled = false,
        settings = {
          profile = "GoogleStyle",
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },
      signatureHelp = { enabled = true },
      references = {
        includeDecompiledSources = true,
      },
      telemetry = {
        enabled = false,
      },
    },
  },
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    -- "-noverify",
    "-Xmx4G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.800.v20240304-1850.jar",
    "-configuration",
    jdtls_path .. "/config_linux",
    "-data",
    "/home/cody/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
  },
  root_dir = function()
    return vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1])
  end,
  handlers = {
    ["language/status"] = function() end,
  },
}

vim.diagnostic.config {
  severity_sort = true,
  float = {
    style = "minimal",
    header = "",
    source = "always",
    wrap_at = 80,
  },
}

