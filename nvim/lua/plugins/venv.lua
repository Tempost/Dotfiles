return {
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      settings = {
        options = {
          on_telescope_result_callback = function(filename)
            return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
          end,
        },
      },
    },
  },
}
