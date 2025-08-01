local M = {}

M.defaults = {
  inlay_hints = {
    enabled = false,
  },
  codelens = {
    enabled = false,
  },
  capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  },
  format = {
    formatting_options = nil,
    timeout_ms = nil,
  },
  on_attach = M.on_attach,
}

M.diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
}

function M.on_attach(client, bufnr)
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })

  local map = function(mode, lhs, rhs, desc)
    local set = vim.keymap.set
    local opts = { buffer = bufnr, silent = true, desc = desc }

    set(mode, lhs, rhs, opts)
  end

  if client:supports_method("definition", bufnr) then
    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  end

  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
  map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("n", "K", vim.lsp.buf.hover, "Hover")

  if client:supports_method("signatureHelp", bufnr) then
    map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
  end

  if client:supports_method("codeAction", bufnr) then
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  end

  map("n", "<leader>cR", function()
    Snacks.rename.rename_file()
  end, "Rename File")

  if client:supports_method("rename", bufnr) then
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
  end

  if client:supports_method("documentHighlight", bufnr) then
    map("n", "]]", function()
      Snacks.words.jump(vim.v.count1, true)
    end, "Next Reference")
    map("n", "[[", function()
      Snacks.words.jump(-vim.v.count1, true)
    end, "Previous Reference")
  end
end

function M.setup()
  vim.lsp.config("*", M.defaults)
  vim.diagnostic.enable(true)
  vim.diagnostic.config(M.diagnostics)
end

return M
