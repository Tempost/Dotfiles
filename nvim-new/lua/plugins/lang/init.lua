require("config.lsp").setup()

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = false,
      ensure_installed = {
        "clangd",
        "bashls",
        "cmake",
        "docker_compose_language_service",
        "dockerls",
        "eslint",
        "jsonls",
        "neocmake",
        "tailwindcss",
        "taplo",
        "vtsls",
        "yamlls",
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
      },
      { "neovim/nvim-lspconfig" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        quite = false,
        lsp_format = "fallback",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>cf",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
  },
}
