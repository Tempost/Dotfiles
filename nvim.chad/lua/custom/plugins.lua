local plugins = {
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings "dap"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function(_, opts)
      local path = "$HOME/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings "dap_python"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    config = function()
      require "custom.configs.none-ls"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "PyLspInstall", "JdtShowLogs" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "stylua",
            "prettier",
            "google-java-format",
            "debugpy",
          },
        },
      },
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "tailwindcss",
        "prismals",
        "pylsp",
        "rust_analyzer",
        "tsserver",
        "gopls",
        "jdtls",
        "sqlls",
        "bashls",
        "spectral",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
    },
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
