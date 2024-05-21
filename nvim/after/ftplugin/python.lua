local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local enable_providers = {
  "python3_provider",
}

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
