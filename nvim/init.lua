-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('packer').startup(function()
  local use = require('packer').use
  use 'wbthomason/packer.nvim' -- Package manager
  use 'rktjmp/lush.nvim'
  use 'catppuccin/nvim'
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  use 'j-hui/fidget.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'akinsho/bufferline.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'onsails/lspkind-nvim'
  use 'L3MON4D3/LuaSnip'
end)

vim.wo.number         = true
vim.wo.relativenumber = true
vim.o.hlsearch        = false
vim.o.mouse           = 'a'
vim.o.ignorecase      = true
vim.o.smartcase       = true
vim.o.updatetime      = 10
vim.o.termguicolors   = true
vim.wo.signcolumn     = 'yes'
vim.opt.scrolloff     = 10
vim.opt.wrap          = true
vim.opt.undofile      = true
vim.opt.pumheight     = 20
vim.opt.tabstop       = 4
vim.opt.shiftwidth    = 4
vim.opt.softtabstop   = 4
vim.opt.expandtab     = true

require('colors_conf')
vim.g.catppuccin_flavour = "frappe"
vim.cmd [[
  set nu
  set hidden
  autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType typescript      setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType javascript      setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType javascriptreact setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType json            setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType html            setlocal shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType lua             setlocal shiftwidth=2 softtabstop=2 tabstop=2
  colorscheme catppuccin

  augroup configurationFiles
    autocmd! BufWritePost init.lua      source %
    autocmd! BufWritePost .tmux.conf    !tmux source-file ~/.tmux.conf
  augroup END
]]

require("bufferline").setup {
  options = {
    indicator_icon     = " ",
    buffer_close_icon  = '',
    modified_icon      = '●',
    close_icon         = '',
    left_trunc_marker  = '',
    right_trunc_marker = '',
    seperator_style    = "thin"
  },
  show_buffer_icons = true,
  color_icons = true
}

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    component_separators = { left = '┃', right = '┃' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'branch', 'mode' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = { 'diagnostics' },
    lualine_y = {},
    lualine_z = { 'filesize' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitGutterAdd', text = '' },
    change       = { hl = 'GitGutterChange', text = 'ﰣ' },
    delete       = { hl = 'GitGutterDelete', text = '' },
    topdelete    = { hl = 'GitGutterDelete', text = '⎴' },
    changedelete = { hl = 'GitGutterChange', text = '≂' },
  },
}

-- ToggleTerm
require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'shadow',
    width = 100,
    height = 100,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}

require('nvim-web-devicons').setup { default = true; }
require('remaps_conf')
require('telescope_conf')
require('treesitter_conf')
require('lsp_conf')
require('luasnip_conf')
require('completion_conf')
