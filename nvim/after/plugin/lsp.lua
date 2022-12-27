require("mason").setup({
  ui = {
    border = "single",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "sumneko_lua",
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

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    diagnostics.djlint,
    diagnostics.tidy,
    formatting.prettier,
    formatting.stylua,
    formatting.black.with({ extra_args = { "--fast" } }),
  },
})

-- require("lspconfig").pylsp.setup({
--   cmd = { "pylsp" },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     pylsp = {
--       plugins = {
--         jedi_completion = {
--           eager = true,
--         },
--         rope_completion = {
--           enable = true,
--           eager = true,
--         },
--         ruff = {
--           enabled = true,
--           lineLength = 100,
--         },
--       },
--     },
--   },
-- })

-- nvim_lsp.sqls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "sql", "mysql", "psql" },
-- })

-- nvim_lsp.tailwindcss.setup({
--   cmd = { "tailwindcss-language-server", "--stdio" },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--   },
-- })

-- nvim_lsp.tsserver.setup({
--   cmd = { "typescript-language-server", "--stdio" },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--   },
-- })

-- nvim_lsp.cssls.setup({
--   cmd = { "vscode-css-language-server", "--stdio" },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "css", "scss" },
-- })

-- nvim_lsp.jsonls.setup({
--   cmd = { "vscode-json-language-server", "--stdio" },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetype = { "json" },
-- })

-- nvim_lsp.rust_analyzer.setup({
--   cmd = { "rust-analyzer" },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

-- nvim_lsp.gopls.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   cmd = { "gopls" },
-- })

-- nvim_lsp.html.setup({
--   cmd = { "vscode-html-language-server", "--stdio" },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

-- -- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

-- nvim_lsp.sumneko_lua.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--         path = runtime_path,
--       },
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- })

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
