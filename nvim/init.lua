require("plugins")

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.hlsearch = false
vim.o.mouse = "a"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 30
vim.o.termguicolors = true
vim.g.gruvbox_baby_transparent_mode = 1
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.wrap = true
vim.opt.undofile = true
vim.opt.pumheight = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.hidden = true

--Map blankline
vim.g.indent_blankline_char = "|"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

vim.g.gruvbox_baby_highlights =
  { visual = { fg = "#123123", bg = "#665c54", style = "NONE" } }
vim.cmd.colorscheme("gruvbox-baby")

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "typescriptreact",
    "typescript",
    "javascript",
    "javascriptreact",
    "json",
    "html",
    "lua",
  },
  callback = function(e)
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
  end,
})

vim.g.python3_host_prog = "~/.virtualenvs/neovim/bin/python3"
