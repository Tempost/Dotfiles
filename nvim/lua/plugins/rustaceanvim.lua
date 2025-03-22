return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allTargets = false,
            },
            check = {
              allTargets = false,
            },
          },
        },
      },
    },
  },
}
