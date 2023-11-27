-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }

-- nvim-cmp setup
local cmp = require("cmp")
local lspkind = require("lspkind")

if cmp ~= nil then
  cmp.setup({
    enabled = function()
      local context = require("cmp.config.context")

      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
      end
    end,
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:MailUrl,Search:None",
        col_offset = -3,
        side_paddng = 0,
      },
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
      ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    }),
    sources = cmp.config.sources({
      { name = "buffer", max_item_count = 5 },
      { name = "nvim_lsp", max_item_count = 20, keyword_length = 2 },
      { name = "luasnip" },
      { name = "cmp_tabnine" },
      { name = "path" },
    }),
    experimental = {
      ghost_text = false,
    },
    view = {
      entries = {
        name = "custom",
        selection_order = "near_cursor",
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind =
          lspkind.cmp_format({ max_width = 20 })(
            entry,
            vim_item
          )
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    (" .. (strings[2] or "") .. ")"

        return kind
      end,
    },
  })
end
