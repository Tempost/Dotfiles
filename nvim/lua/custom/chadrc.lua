---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'sweetpastel',
  transparency = false,
  lsp_semantic_tokens = true,
  telescope = {
    style = "bordered"
  }
}

M.plugins = "custom.plugins"

return M
