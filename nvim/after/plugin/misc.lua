require('bufferline').setup {
  options = {
    indicator = {
      style = 'icon',
      icon = ' '
    },
    buffer_close_icon  = '',
    modified_icon      = '●',
    close_icon         = '',
    left_trunc_marker  = '',
    right_trunc_marker = '',
    seperator_style    = 'thin',
    show_buffer_icons  = true,
    color_icons        = true
  },
}

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-baby',
    component_separators = { left = '|', right = '|' },
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
require('toggleterm').setup {
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'single',
    height = 50,
    width = 150,
  }
}

require('nvim-web-devicons').setup { default = true; }
require('leap').add_default_mappings()
