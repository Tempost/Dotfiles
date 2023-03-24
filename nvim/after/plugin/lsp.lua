require("mason").setup({
  ui = {
    border = "single",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "cssls",
    "jsonls",
    "html",
    "eslint",
    "gopls",
  },
})

vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_test = true,
  float = {
    border = "single",
  },
})


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] =
vim.lsp.with(vim.lsp.handlers.signatureHelp, {
  border = "single",
})

local config = require("config")
local nvim_lsp = require("lspconfig")

for _, server in pairs(config.servers) do
  local cmd = server[2]
  nvim_lsp[server[1]].setup({
    cmd = cmd,
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    filetypes = server[3],
    flags = config.lsp_flags,
    settings = server[4],
  })
end

require("typescript").setup({
  server = {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    flags = config.lsp_flags,
  }
})

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  debounce = 80,
  border = "single",
  sources = {
    diagnostics.tidy,
    diagnostics.eslint,
    formatting.prettier,
    formatting.stylua,
    formatting.xmlformat,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.google_java_format,
    formatting.beautysh,
    require("typescript.extensions.null-ls.code-actions"),
  },
})


require("fidget").setup({
  text = {
    spinner = "dots", -- animation shown when tasks are ongoing
    done = "", -- character shown when all tasks are complete
    commenced = "Started", -- message shown when task starts
    completed = "Completed", -- message shown when task completes
  },
  align = {
    bottom = true, -- align fidgets along bottom edge of buffer
    right = true, -- align fidgets along right edge of buffer
  },
  timer = {
    spinner_rate = 144, -- frame rate of spinner animation, in ms
    fidget_decay = 2000, -- how long to keep around empty fidget, in ms
    task_decay = 1000, -- how long to keep around completed task, in ms
  },
  window = {
    relative = "editor", -- where to anchor, either "win" or "editor"
    blend = 0, -- &winblend for the window
    zindex = 10, -- the zindex value for the window
  },
  fmt = {
    leftpad = true, -- right-justify text in fidget box
    stack_upwards = true, -- list of tasks grows upwards
    max_width = 0, -- maximum width of the fidget box
    -- function to format fidget title
    fidget = function(fidget_name, spinner)
      return string.format("%s %s", spinner, fidget_name)
    end,
    -- function to format each task line
    task = function(task_name, message, percentage)
      return string.format(
        "%s%s [%s]",
        message,
        percentage and string.format(" (%s%%)", percentage) or "",
        task_name
      )
    end,
  },
  debug = {
    logging = false, -- whether to enable logging, for debugging
  },
})
