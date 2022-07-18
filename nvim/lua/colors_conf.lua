local catppuccin = require("catppuccin")

catppuccin.setup({
  transparent_background = true,
  term_colors = false,
  styles = {
    comments = "bold",
    functions = "bold",
    keywords = "bold",
    strings = "NONE",
    variables = "italic",
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "bold",
        hints = "italic",
        warnings = "bold",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    cmp = true,
    gitsigns = true,
    lsp_saga = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = false,
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dashboard = true,
    bufferline = true,
    markdown = true,
  }
})
