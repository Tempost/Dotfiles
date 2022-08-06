vim.cmd[[
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  nnoremap <leader>l :lnext<CR>
  nnoremap <leader>h :lprevious<CR>
]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Custom maps i use often
vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>w<cr>',                                          { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>q<cr>',                                          { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>`', '<cmd>source /home/tempost/.config/nvim/init.lua<cr>', { noremap = true, silent = true})
-- swap between prev and next buffer in the list
vim.api.nvim_set_keymap('n', '<leader>bn', '<cmd>bn<cr>',                                        { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd>bp<cr>',                                        { noremap = true, silent = true})

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  -- function to run on opening the terminal
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
})

local yarndev = Terminal:new({
  cmd = "yarn run dev",
  direction = "float",
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("stopinsert")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  count = 2
})

local jesttest = Terminal:new({
  cmd = "yarn run test",
  direction = "float",
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("stopinsert")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  count = 2
})

function _lazygit_toggle()
  lazygit:toggle()
end

function _yarndev_toggle()
  yarndev:spawn()
end

vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>ty", "<cmd>lua _yarndev_toggle()<CR>", {noremap = true, silent = true})
