-- LSP keybind settings
local nvim_lsp = require('lspconfig')
local saga = require('lspsaga')

-- some generic keybinds
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,     {buffer = 0}) -- zero means current buffer
    vim.keymap.set("n", "K",          '<cmd>Lspsaga hover_doc<cr>',           {buffer = 0})
    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation,  {buffer = 0})
    vim.keymap.set("n", "<leader>D",  vim.lsp.buf.type_definition, {buffer = 0})
    vim.keymap.set("n", "<leader>r",  '<cmd>Lspsaga rename<cr>',   {buffer = 0, silent = true})
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,      {buffer = 0})
    vim.keymap.set("n", "<leader>ga", '<cmd>Lspsaga code_action<cr>',     {buffer = 0, silent = true})
    vim.keymap.set("n", "<leader>gf", '<cmd>Lspsaga show_line_diagnostics<cr>',   {buffer = 0, silent = true})
    vim.keymap.set("n", "<leader>gj", '<cmd>Lspsaga diagnostic_jump_next<cr>',    {buffer = 0, silent = true})
    vim.keymap.set("n", "<leader>gk", '<cmd>Lspsaga diagnostic_jump_prev<cr>',    {buffer = 0, silent = true})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = {'pyright'}
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
  filetypes = {"css", "scss"}
}

nvim_lsp.jsonls.setup {
  cmd = {'vscode-json-language-server', '--stdio'},
  on_attach = on_attach,
  capabilities = capabilities,
  filetype = {"json"}
}

-- nvim_lsp.tailwindcss.setup {
--   cmd = {"tailwindcss-language-server", "--stdio"},
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
-- }

nvim_lsp.clangd.setup {
    cmd = { 'clangd' },
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.rust_analyzer.setup {
  cmd       = { 'rust-analyzer' },
  on_attach = function()
    -- how can i hoist out the common remaps?
    vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,     {buffer = 0}) -- zero means current buffer
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,           {buffer = 0})
    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation,  {buffer = 0})
    vim.keymap.set("n", "<leader>D",  vim.lsp.buf.type_definition, {buffer = 0})
    vim.keymap.set("n", "<leader>r",  vim.lsp.buf.rename,          {buffer = 0})
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,      {buffer = 0})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,     {buffer = 0})
    vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float,   {buffer = 0})
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next,    {buffer = 0})
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev,    {buffer = 0})
    vim.keymap.set("n", "<leader>br", '<cmd>w | make run<cr>',     {buffer = 0})
    vim.keymap.set("n", "<leader>bb", '<cmd>w | make build<cr>',   {buffer = 0})
    vim.keymap.set("n", "<leader>bc", '<cmd>w | make check<cr>',    {buffer = 0})
    vim.keymap.set("n", "<leader>bt", '<cmd>w | make test --lib -- --show-output<cr>',    {buffer = 0})
  end,
  capabilities = capabilities,

}

nvim_lsp.gopls.setup {
  capabilities = capabilities,
  cmd       = { 'gopls' },
  on_attach = function()
    vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,     {buffer = 0}) -- zero means current buffer
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,           {buffer = 0})
    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation,  {buffer = 0})
    vim.keymap.set("n", "<leader>D",  vim.lsp.buf.type_definition, {buffer = 0})
    vim.keymap.set("n", "<leader>r",  vim.lsp.buf.rename,          {buffer = 0})
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,      {buffer = 0})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,     {buffer = 0})
    vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float,   {buffer = 0})
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next,    {buffer = 0})
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev,    {buffer = 0})
  end
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
  cmd          = {"/home/cody/lua-language-server/bin/lua-language-server" },
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

saga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = false,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = false,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },

  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
}

require('fidget').setup {
  text = {
    spinner = "dots",         -- animation shown when tasks are ongoing
    done = "",               -- character shown when all tasks are complete
    commenced = "Started",    -- message shown when task starts
    completed = "Completed",  -- message shown when task completes
  },
  align = {
    bottom = true,            -- align fidgets along bottom edge of buffer
    right = true,             -- align fidgets along right edge of buffer
  },
  timer = {
    spinner_rate = 125,       -- frame rate of spinner animation, in ms
    fidget_decay = 2000,      -- how long to keep around empty fidget, in ms
    task_decay = 1000,        -- how long to keep around completed task, in ms
  },
  window = {
    relative = "editor",      -- where to anchor, either "win" or "editor"
    blend = 0,                -- &winblend for the window
    zindex = nil,             -- the zindex value for the window
  },
  fmt = {
    leftpad = true,           -- right-justify text in fidget box
    stack_upwards = true,     -- list of tasks grows upwards
    max_width = 0,            -- maximum width of the fidget box
    fidget =                  -- function to format fidget title
      function(fidget_name, spinner)
        return string.format("%s %s", spinner, fidget_name)
      end,
    task =                    -- function to format each task line
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
    logging = false,          -- whether to enable logging, for debugging
  },
}
