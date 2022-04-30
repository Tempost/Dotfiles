require("trouble").setup {}

-- Telescope
require('telescope').setup {
  defaults = {
    prompt_prefix   = "❯ ",
    selection_caret = "❯ ",
    winblend        = 0,
    layout_strategy = "horizontal",
    layout_config = {
      width           = 0.95,
      height          = 0.85,
      prompt_position = "top",
      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
      vertical = {
        width          = 0.9,
        height         = 0.95,
        preview_height = 0.5,
      },
      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    file_ignore_patterns = { "node_modules", "target", ".git" },
  },
    file_previewer   = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer   = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  extensions = {
    fzf = {
      fuzzy                   = true,
      override_generic_sorter = true,
      override_file_sorter    = true,
      case_mode               = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],                          { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sf',      [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb',      [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh',      [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>st',      [[<cmd>lua require('telescope.builtin').tags()<CR>]],                             { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ss',      [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],                      { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sg',      [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd',      [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],                         { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sr',      [[<cmd>lua require('telescope.builtin').reloader()<CR>]],                         { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sk',      [[<cmd>lua require('telescope.builtin').keymaps()<CR>]],                          { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sca',     [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]],                 { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
