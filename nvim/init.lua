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
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use ({'catppuccin/nvim', as ="catppuccin"})
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'j-hui/fidget.nvim'
  use {"akinsho/toggleterm.nvim"}
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'onsails/lspkind-nvim'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
end)

require('colors_conf')

vim.o.hlsearch        = false
vim.wo.number         = true
vim.wo.relativenumber = true
vim.o.mouse           = 'a'
vim.opt.undofile      = true
vim.o.ignorecase      = true
vim.o.smartcase       = true
vim.o.updatetime      = 30
vim.wo.signcolumn     = 'yes'
vim.opt.scrolloff     = 10
vim.opt.wrap          = true
vim.opt.cursorline    = true
vim.opt.pumheight     = 20
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.o.termguicolors = true
vim.cmd [[
  set nu
  set hidden
  autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 tabstop=2
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

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {{
      'buffers',
      show_filename_only = true,
      show_modified_status = true,
      mode = 2
    }},
    lualine_x = {'encoding'},
    lualine_y = {'diagnostics'},
    lualine_z = {'filesize'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

--Map blankline
vim.g.indent_blankline_char                           = '|'
vim.g.indent_blankline_filetype_exclude               = { 'help',     'packer' }
vim.g.indent_blankline_buftype_exclude                = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitGutterAdd',    text = '＋' },
    change       = { hl = 'GitGutterChange', text = '~'  },
    delete       = { hl = 'GitGutterDelete', text = '－' },
    topdelete    = { hl = 'GitGutterDelete', text = '⎴'  },
    changedelete = { hl = 'GitGutterChange', text = '≂'  },
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
