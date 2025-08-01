return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        autoImportCompletions = true,
        ignore = { "*" },
      },
    },
    python = {
      pythonPath = vim.g.python3_host_prog,
    },
  },
}
