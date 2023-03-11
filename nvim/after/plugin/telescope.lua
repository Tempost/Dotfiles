local nnoremap = require("keymap").nnoremap

-- Telescope
require("telescope").setup({
	defaults = {
		prompt_prefix = "",
		selection_caret = "",
		winblend = 0,
		layout_strategy = "horizontal",
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
			"node_modules",
			"target",
			".git",
			"python/",
			"translation/",
			"%.jpg",
			"%.png",
			"%.svg",
			"%.jpeg",
		},
	},
	file_previewer = require("telescope.previewers").vim_buffer_cat.new,
	grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
	qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
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

nnoremap("<leader><space>", [[<cmd>Telescope file_browser<CR>]])
nnoremap("<leader>sf", [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]])
nnoremap("<leader>sb", [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
nnoremap("<leader>sh", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
nnoremap("<leader>st", [[<cmd>lua require('telescope.builtin').tags()<CR>]])
nnoremap("<leader>ss", [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
nnoremap("<leader>sg", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
nnoremap("<leader>sd", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
nnoremap("<leader>sr", [[<cmd>lua require('telescope.builtin').reloader()<CR>]])
nnoremap("<leader>sk", [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
nnoremap("<leader>tt", [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]])
