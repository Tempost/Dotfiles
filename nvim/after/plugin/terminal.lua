-- ToggleTerm
require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = "single",
		height = 50,
		width = 150,
	},
})

local nnoremap = require("keymap").nnoremap
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	direction = "float",
	hidden = true,
})
local studio = Terminal:new({
	cmd = "pnpm studio",
	direction = "float",
	hidden = true,
	on_open = function(term)
		vim.cmd("stopinsert")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	count = 2,
})

function lazygit_toggle()
	lazygit:toggle()
end

function studio_toggle()
	studio:spawn()
end

nnoremap("<leader>tg", "<cmd>lua lazygit_toggle()<cr>")
nnoremap("<leader>ty", "<cmd>lua studio_toggle()<cr>")
