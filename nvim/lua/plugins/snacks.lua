return {
  {
    "snacks.nvim",
    opts = {
      scroll = {
        enabled = false,
      },
      picker = {
        exclude = {
          "build/*",
          "bin/*",
        },
      },

      dashboard = {
        preset = {
          header = [[
( ) ( )              ( ) ( ) _            
| `\| |   __     _   | | | |(_)  ___ ___  
| , ` | /'__`\ /'_`\ | | | || |/' _ ` _ `\
| |`\ |(  ___/( (_) )| \_/ || || ( ) ( ) |
(_) (_)`\____)`\___/'`\___/'(_)(_) (_) (_)]],
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "d",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = '/home/cody/src/Dotfiles'})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
