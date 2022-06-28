-- LSP keybind settings
local nvim_lsp = require('lspconfig')

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" }, -- top
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" }, -- right
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" }, -- bottom
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" }, -- left
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  float = { border = border },
})

-- some generic keybinds
local on_attach = function(_, bufnr)
  local bufopts = { buffer = bufnr, silent = true }
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- zero means current buffer
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>gf", vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "<leader>gj", vim.diagnostic.goto_next, bufopts)
  vim.keymap.set("n", "<leader>gk", vim.diagnostic.goto_prev, bufopts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

nvim_lsp.tsserver.setup {
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}

-- nvim_lsp.eslint.setup {
--   cmd = { "vscode-eslint-language-server", "--stdio" },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
-- }

nvim_lsp.cssls.setup {
  cmd = { "vscode-css-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "css", "scss" }
}

nvim_lsp.jsonls.setup {
  cmd = { 'vscode-json-language-server', '--stdio' },
  on_attach = on_attach,
  capabilities = capabilities,
  filetype = { "json" }
}

nvim_lsp.html.setup {
  cmd          = { "vscode-html-languageserver", "--stdio" },
  on_attach    = on_attach,
  capabilities = capabilities
}

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
  cmd          = { "/home/cody/lua-language-server/bin/lua-language-server" },
  on_attach    = on_attach,
  capabilities = capabilities,
  settings     = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path    = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

require('fidget').setup {
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
    spinner_rate = 125, -- frame rate of spinner animation, in ms
    fidget_decay = 2000, -- how long to keep around empty fidget, in ms
    task_decay = 1000, -- how long to keep around completed task, in ms
  },
  window = {
    relative = "editor", -- where to anchor, either "win" or "editor"
    blend = 0, -- &winblend for the window
    zindex = nil, -- the zindex value for the window
  },
  fmt = {
    leftpad = true, -- right-justify text in fidget box
    stack_upwards = true, -- list of tasks grows upwards
    max_width = 0, -- maximum width of the fidget box
    fidget = -- function to format fidget title
    function(fidget_name, spinner)
      return string.format("%s %s", spinner, fidget_name)
    end,
    task = -- function to format each task line
    function(task_name, message, percentage)
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
}
