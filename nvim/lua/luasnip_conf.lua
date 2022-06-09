local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config {
  history = true,
  updateevents = "TextChanged, TextChangedI",
  enable_autosnippets = false,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<--", "Error" } },
      },
    },
  },
}

-- if we can jump forwards in the snippet then do so
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jumpable()
  end
end, { silent = true })

-- if we can jump backwards in the snippet then do so
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- List options
vim.keymap.set({ "i" }, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice()
  end
end)
