return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python", "jinja", "jinja_inline", "ninja", "rst" } },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ruff",
        "basedpyright",
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    enabled = false, -- Wait until PR [208] (https://github.com/linux-cultist/venv-selector.nvim/pull/208) is merged
    branch = "regexp",
    cmd = "VenvSelect",
    ft = "python",
    opts = {
      settings = {
        options = {
          on_telescope_result_callback = function(filename)
            return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
          end,
        },
      },
    },
  },
}
