local options = {
  extensions_list = { "ui-select", "fzf", "terms", "themes" },
  file_ignore_patterns = {
    "__pycache__",
    "node_modules",
    "target/",
    "%.jpg",
    "%.png",
    "%.svg",
    "%.jpeg",
    "build/",
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

return vim.tbl_deep_extend("keep", options, require "nvchad.configs.telescope")
