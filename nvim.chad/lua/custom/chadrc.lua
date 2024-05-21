---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'everforest',
  transparency = false,
  lsp_semantic_tokens = true,
  telescope = {
    style = "bordered"
  }
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
