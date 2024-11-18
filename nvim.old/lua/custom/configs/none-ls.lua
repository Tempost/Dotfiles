local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  debounce = 80,
  border = "rounded",
  sources = {
    diagnostics.tidy.with { disabled_filetypes = { "xml" } },
    diagnostics.eslint,
    formatting.prettier.with { disabled_filetypes = { "json" } },
    formatting.beautysh,
    formatting.google_java_format,
    formatting.stylua,
  },
}
