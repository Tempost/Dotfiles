local plugins = {
  {},
  {
    "williamboman/mason.nvim",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        config = function()
          require "custom.configs.none-ls"
        end,
      },
    },
    opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "prisma-language-server",
        "stylua",
        "prettier",
        "eslint-lsp",
        "python-lsp-server",
        "rust-analyzer",
        "typescript-language-server",
        "gopls",
        "google-java-format",
        "black",
        "jdtls",
        "sqlls",
        "bash-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function()
      local conf = require "plugins.configs.telescope"
      conf.defaults = {
        prompt_prefix = "",
        selection_caret = "",
        winblend = 0,
        layout_strategy = "vertical",
        layout_config = {
          width = 0.75,
          height = 0.90,
          prompt_position = "top",
          horizontal = {
            preview_width = function(_, cols, _)
              if cols > 200 then
                return math.floor(cols * 0.4)
              else
                return math.floor(cols * 0.6)
              end
            end,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
          },
          flex = {
            horizontal = {
              preview_width = 0.9,
            },
          },
        },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
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
      }
      conf.extensions_list = { "themes", "terms", "fzf", "ui-select" }
      conf.extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {},
        },
      }
    end,
  },
}

return plugins
