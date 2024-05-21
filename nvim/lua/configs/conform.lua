local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    java = { "google-java-format" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
}

require("conform").setup(options)
