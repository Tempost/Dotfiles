require('bufferline').setup {
  options = {
    indicator          = {
      icon = ' ',
      style = 'icon',
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

require('nvim-web-devicons').setup { default = true; }
