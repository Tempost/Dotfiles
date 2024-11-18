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

local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
local launcher_path = vim.fs.find(function(name, _)
  return name:match "org.eclipse.equinox.launcher_.*"
end, { path = jdtls_path .. "/plugins" })[1]

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
    launcher_path,
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
