return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.none-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "nvchad.configs.mason"
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌",
        },

        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
      },
      ensure_installed = {
        "stylua",
        "lua-language-server",
        "typescript-language-server",
        "prettier",
        "tailwindcss-language-server",
        "prisma-language-server",
        "python-lsp-server",
        "rust-analyzer",
        "gopls",
        "jdtls",
        "google-java-format",
        "sqlls",
        "bash-language-server",
        "spectral-language-server",
      },
    },
  },
  { "folke/neodev.nvim" },
  {
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    lazy = false,
    opts = require("configs.treesitter").opts,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    opts = function()
      return require "configs.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup()

      vim.keymap.set("n", "<m-h><m-m>", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<m-h><m-l>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      -- Set <space>1..<space>5 be my shortcuts to moving to the files
      for _, idx in ipairs { 1, 2, 3, 4, 5 } do
        vim.keymap.set("n", string.format("<space>%d", idx), function()
          harpoon:list():select(idx)
        end)
      end
    end,
  }
}
