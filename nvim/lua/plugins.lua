-- Install packer
local install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute(
    "!git clone https://github.com/wbthomason/packer.nvim " .. install_path
  )
end

vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]])

require("packer").startup(function()
  local use = require("packer").use
  use("wbthomason/packer.nvim") -- Package manager

  -- Colors
  use("rktjmp/lush.nvim")
  use("luisiacc/gruvbox-baby")

  use("tpope/vim-commentary") -- 'gc' to comment visual regions/lines
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use("nvim-telescope/telescope-dap.nvim")
  -- Add indentation guides even on blank lines
  use("lukas-reineke/indent-blankline.nvim")
  -- Add git related info in the signs columns and popups
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use("nvim-treesitter/nvim-treesitter")
  use("folke/trouble.nvim")
  use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client

  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  use("mfussenegger/nvim-jdtls")
  use("mfussenegger/nvim-dap")

  use("hrsh7th/nvim-cmp") -- Autocompletion plugin
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-buffer")

  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

  use({ "j-hui/fidget.nvim", tag = "legacy" })

  use("akinsho/toggleterm.nvim")
  use("akinsho/bufferline.nvim")

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use("onsails/lspkind-nvim")
  use("kyazdani42/nvim-web-devicons")
  use("ggandor/leap.nvim")
  use("nvimtools/none-ls.nvim")
  use("jose-elias-alvarez/typescript.nvim")

  use("simrat39/rust-tools.nvim")

  use({
    "saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup()
    end,
  })
end)
