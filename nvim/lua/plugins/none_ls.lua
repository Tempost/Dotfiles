return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local asm = {
        method = nls.methods.FORMATTING,
        filetypes = { "asm" },
        generator = nls.formatter({ command = "asmfmt", to_stdin = true }),
      }
      opts.sources = vim.list_extend(opts.sources, { asm, nls.builtins.formatting.google_java_format })
    end,
  },
}
