return {
  {
    "coder/claudecode.nvim",
    opts = {
      terminal_cmd = "~/.local/bin/claude",
      terminal = {
        provider = "none",
        -- ---@module "snacks"
        -- ---@type snacks.win.Config | {}
        -- snacks_win_opts = {
        --   position = "float",
        --   width = 0.9,
        --   height = 0.9,
        --   keys = {
        --     claude_hide = {
        --       "<leader>af",
        --       function(self)
        --         self:hide()
        --       end,
        --       mode = "t",
        --       desc = "Hide Claude",
        --     },
        --   },
        -- },
      },
    },
  },
}
