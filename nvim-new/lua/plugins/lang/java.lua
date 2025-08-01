return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "java", "xml", "javadoc" } },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    lazy = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = { "folke/which-key.nvim" },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.google_java_format)
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
      },
    },
  },
}
