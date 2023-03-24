-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }

-- nvim-cmp setup
local cmp = require("cmp")
local lspkind = require("lspkind")

local winhighlight = {
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
}

if cmp ~= nil then
  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(winhighlight),
      documentation = cmp.config.window.bordered(winhighlight),
    },
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
      ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", max_item_count = 20 },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer", keyword_length = 2 },
      { name = "cmp_tabnine" },
    }),
    experimental = {
      ghost_text = true,
    },
    view = {
      entries = {
        name = "custom",
        selection_order = "near_cursor",
      },
    },
    formatting = {
      format = lspkind.cmp_format({
        with_text = false, -- do not show text alongside icons
        maxwidth = 75, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      }),
    },
  })
end
