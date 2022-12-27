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

-- LSP keybind settings
local nvim_lsp = require("lspconfig")

vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] =
vim.lsp.with(vim.lsp.handlers.signatureHelp, {
  border = "rounded",
})

local nnoremap = require("keymap").nnoremap

-- some generic keybinds
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  nnoremap("K", vim.lsp.buf.hover, bufopts)
  nnoremap("gd", vim.lsp.buf.definition, bufopts) -- zero means current buffer
  nnoremap("gs", vim.lsp.buf.signature_help, bufopts)
  nnoremap("gi", vim.lsp.buf.implementation, bufopts)
  nnoremap("gr", vim.lsp.buf.references, bufopts)
  nnoremap("<leader>ga", vim.lsp.buf.code_action, bufopts)
  nnoremap("<leader>gf", vim.diagnostic.open_float, bufopts)
  nnoremap("<leader>gj", vim.diagnostic.goto_next, bufopts)
  nnoremap("<leader>gk", vim.diagnostic.goto_prev, bufopts)
  nnoremap("<leader>D", vim.lsp.buf.type_definition, bufopts)
  nnoremap("<leader>r", vim.lsp.buf.rename, bufopts)
  nnoremap(
    "<space>lw",
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    bufopts
  )
  vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

require("lspconfig").pylsp.setup({
  cmd = { "pylsp" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = {
          eager = true,
        },
        rope_completion = {
          enable = true,
          eager = true,
        },
        ruff = {
          enabled = true,
          lineLength = 100,
        },
      },
    },
  },
})

nvim_lsp.sqls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "sql", "mysql", "psql" },
})

nvim_lsp.tailwindcss.setup({
  cmd = { "tailwindcss-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
})

nvim_lsp.tsserver.setup({
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
})

nvim_lsp.cssls.setup({
  cmd = { "vscode-css-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "css", "scss" },
})

nvim_lsp.jsonls.setup({
  cmd = { "vscode-json-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetype = { "json" },
})

nvim_lsp.rust_analyzer.setup({
  cmd = { "rust-analyzer" },
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "gopls" },
})

nvim_lsp.html.setup({
  cmd = { "vscode-html-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
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
