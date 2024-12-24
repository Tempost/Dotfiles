local M = {}

M.opts = {
  ensure_installed = {
    "lua",
    "luadoc",
    "diff",
    "gitignore",
    "gitcommit",
    "go",
    "make",
    "markdown",
    "comment",
    "printf",
    "vim",
    "vimdoc",
    "requirements",
    "rust",
    "toml",
    "xml",
    "json",
    "yaml",
    "typescript",
    "javascript",
    "tsx",
    "css",
    "html",
    "csv",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

M.setup = function()
end

return M
