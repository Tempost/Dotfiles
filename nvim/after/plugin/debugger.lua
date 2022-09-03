local dap = require("dap")
local nnoremap = require("keymap").nnoremap

require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

dap.defaults.fallback.external_terminal = {
	command = "/usr/bin/tmux",
	args = { "new-window" },
}

table.insert(require("dap").configurations.python, {
	type = "python",
	request = "launch",
	name = "Flask",
	program = ".venv/bin/flask",
	console = "externalTerminal",
	args = { "run", "--host=0.0.0.0" },
	env = {
		FLASK_ENV = "development",
		FLASK_APP = "server.py",
	},
})

require("nvim-dap-virtual-text").setup()

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })

require("telescope").load_extension("dap")

nnoremap("<F5>", '<cmd>lua require"dap".continue()<CR>')
nnoremap("<F10>", '<cmd>lua require"dap".step_over()<CR>')
nnoremap("<F11>", '<cmd>lua require"dap".step_into()<CR>')
nnoremap("<F12>", '<cmd>lua require"dap".step_out()<CR>')
nnoremap("<F9>", '<cmd>lua require"dap".toggle_breakpoint()<CR>')
nnoremap("<leader>B", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
nnoremap("<leader>lp", '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')

-- telescope-dap
nnoremap("<leader>db", '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
nnoremap("<leader>dv", '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
