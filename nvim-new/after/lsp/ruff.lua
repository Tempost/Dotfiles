return {
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git", "requirements.txt" },
  cmd_env = { RUFF_TRACE = "messages" },
  init_options = {
    settings = {
      logLevel = "error",
    },
  },
}
