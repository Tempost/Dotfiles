require "nvchad.options"

local opt = vim.opt

opt.inccommand = "split"
opt.formatoptions:remove "o"
opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }
