return {
  {
    "neanias/everforest-nvim",
    priority = 1000,
    config = function()
      require("everforest").load()
    end,
  },
}
