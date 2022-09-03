local dap = require('dap')
dap.adapters.lldb = {
  type    = 'executable',
  command = '/usr/bin/lldb-vscode',
  name    = 'lldb'
}

dap.configurations.cpp = {
  {
    name    = "Launch",
    type    = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd          = '${workspaceFolder}',
    stopOnEntry  = false,
    args         = {},
    runInTerminal = true,
  },
}

dap.configurations.c    = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("nvim-dap-virtual-text").setup()

vim.fn.sign_define('DapBreakpoint', {text='⚫', texthl='', linehl='', numhl=''})

require('telescope').load_extension('dap')

local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>B', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lp', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)

-- telescope-dap
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
