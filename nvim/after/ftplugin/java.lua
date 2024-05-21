local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

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
