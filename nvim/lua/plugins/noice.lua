return {
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        hover = { silent = true },
      },
      -- routes = {
      --   {
      --     filter = {
      --       event = "lsp",
      --       kind = "progress",
      --       cond = function(message)
      --         local client = vim.tbl_get(message.opts, "progress", "client")
      --         return client == "jdtls"
      --       end,
      --     },
      --     opts = { skip = true },
      --   },
      -- },
    },
  },
}
