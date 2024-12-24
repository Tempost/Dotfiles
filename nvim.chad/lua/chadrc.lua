-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@class ChadrcConfig
local M = {}

M.ui = {
  lsp_semantic_tokens = true,
  cmp = {
    format_colors = {
      tailwind = true,
    },
  },
  telescope = {
    style = "bordered",
  },
}

M.base46 = {
  theme = "everforest",
  transparency = false,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.mason = {
  cmd = true,
  pkgs = {
    "stylua",
    "lua-language-server",
    "typescript-language-server",
    "prettier",
    "json-lsp",
    "tailwindcss-language-server",
    "prisma-language-server",
    "rust-analyzer",
    "gopls",
    "sqlls",
    "bash-language-server",
    "spectral-language-server",
  },
}

return M
