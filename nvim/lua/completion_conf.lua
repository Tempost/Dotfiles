-- Set completeopt to have a better completion experience
vim.opt.completeopt = {"menu", "menuone", "noselect"}

-- nvim-cmp setup
local cmp = require ('cmp')
local lspkind = require('lspkind')

cmp.setup {
  snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select   = true,
    },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 15 },
    { name = 'luasnip'                       },
    { name = 'path'                          },
    { name = 'buffer',   keyword_length = 2  },
  }),
  experimental = {
    native_menu = false,
    ghost_text  = true
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = false, -- do not show text alongside icons
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function (entry, vim_item)
      --   ...
      --   return vim_item
      -- end
    })
  }
}
