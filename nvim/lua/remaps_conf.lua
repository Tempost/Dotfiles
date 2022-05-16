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
