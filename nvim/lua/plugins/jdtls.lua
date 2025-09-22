return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      cmd = { "/opt/eclipse.jdt.ls/bin/jdtls" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["java"] = { "google-java-format" },
      },
    },
  },
}
