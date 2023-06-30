local map = require("keymap")

vim.cmd([[
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  nnoremap <leader>l :lnext<CR>
  nnoremap <leader>h :lprevious<CR>
]])

--Remap space as leader key
vim.api.nvim_set_keymap(
  "",
  "<Space>",
  "<Nop>",
  { noremap = true, silent = true }
)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
map.nnoremap(
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { noremap = true, expr = true, silent = true }
)
map.nnoremap(
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { noremap = true, expr = true, silent = true }
)

-- Custom maps i use often
map.nnoremap("<leader>w", "<cmd>w<cr>")
map.nnoremap("<leader>e", "<cmd>q<cr>")
map.nnoremap("<leader>`", "<cmd>source /home/cody/.config/nvim/init.lua<cr>")
map.nnoremap("<leader>co", "<cmd>cw<cr>")
map.nnoremap("<leader>cn", "<cmd>cn<cr>")
map.nnoremap("<leader>cp", "<cmd>cp<cr>")

map.nnoremap("<leader>bn", "<cmd>bn<cr>")
map.nnoremap("<leader>bp", "<cmd>bp<cr>")
map.nnoremap("<leader>bd", "<cmd>bd<cr>")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local yarndev = Terminal:new({
  md = "yarn run start",
  hidden = true,
  on_open = function(term)
    vim.cmd("stopinsert")
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "q",
      "<cmd>close<CR>",
      { noremap = true, silent = true }
    )
  end,
  count = 2,
})

function lazygit_toggle() lazygit:toggle() end

function yarndev_toggle() yarndev:spawn() end

map.nnoremap("<leader>tg", "<cmd>lua lazygit_toggle()<cr>")
map.nnoremap("<leader>ty", "<cmd>lua yarndev_toggle()<cr>")

map.vnoremap("<leader>d64", "c<c-r>=system('base64 --decode', @\")<cr><esc>")
map.vnoremap("<leader>n64", "c<c-r>=system('base64', @\")<cr><esc>")
