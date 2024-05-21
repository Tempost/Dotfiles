local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "ccls",
  "clangd",
  "jsonls",
  "bashls",
  "tailwindcss",
  "gopls",
  "rust_analyzer",
  "sqlls",
  "prismals",
  "spectral",
}

require("neodev").setup()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = vim.keymap.set
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    if client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
    end

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.diagnostic.config {
      severity_sort = true,
      float = {
        style = "minimal",
        header = "",
        source = true,
        wrap_at = 80,
      },
    }

    map("n", "<leader>lf", function()
      vim.diagnostic.open_float { border = "rounded" }
    end, { desc = "Open float diagnostic menu" })
  end,
})

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
