local nnoremap = require("keymap").nnoremap
require("trouble").setup({})

-- Telescope
require("telescope").setup({
  defaults = {
    prompt_prefix = "",
    selection_caret = "",
    winblend = 0,
    layout_strategy = "vertical",
    layout_config = {
      width = 0.75,
      height = 0.90,
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
        width = 0.9,
        height = 0.95,
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
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    file_ignore_patterns = {
      "__pycache__",
      "node_modules",
      "target/",
      "%.jpg",
      "%.png",
      "%.svg",
      "%.jpeg",
      "build/",
    },
  },
  file_previewer = require("telescope.previewers").vim_buffer_cat.new,
  grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
  qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
      }),
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("dap")

--Add leader shortcuts
nnoremap("<leader><space>", "<cmd>Telescope file_browser<cr>")
nnoremap("<leader>sq", "<cmd>Telescope quickfix<cr>")
nnoremap( "<leader>sf", "<cmd>Telescope find_files<cr>")
nnoremap( "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
nnoremap( "<leader>sh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>st", "<cmd>Telescope tags<cr>")
nnoremap( "<leader>ss", "<cmd>Telescope grep_string<cr>")
nnoremap("<leader>sg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>sd", "<cmd>Telescope oldfiles<cr>")
nnoremap("<leader>sk", "<cmd>Telescope keymaps<cr>")
nnoremap("<leader>tt", "<cmd>Telescope diagnostics<cr>")
