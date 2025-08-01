return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        enabled = true,
      },
    },
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)

      vim.notify = notify
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      default = {},
    },
  },
}
