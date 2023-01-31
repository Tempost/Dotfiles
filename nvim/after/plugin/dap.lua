local function add_tagfunc(widget)
  local orig_new_buf = widget.new_buf
  widget.new_buf = function(...)
    local bufnr = orig_new_buf(...)
    vim.api.nvim_buf_set_option(
      bufnr,
      "tagfunc",
      "v:lua.require'ext'.symbol_tagfunc"
    )
    return bufnr
  end
end

local dap = require("dap")

dap.set_log_level("INFO")

local widgets = require("dap.ui.widgets")
add_tagfunc(widgets.expression)
add_tagfunc(widgets.scopes)

local keymap = vim.keymap
local function set(mode, lhs, rhs) keymap.set(mode, lhs, rhs, { silent = true }) end

set({ "n", "t" }, "<F3>", dap.terminate)
set({ "n", "t" }, "<F5>", dap.continue)
set("n", "<leader>b", dap.toggle_breakpoint)
set(
  "n",
  "<leader>B",
  function()
    dap.toggle_breakpoint(
      vim.fn.input("Breakpoint Condition: "),
      nil,
      nil,
      true
    )
  end
)
set(
  "n",
  "<leader>lp",
  function()
    dap.toggle_breakpoint(nil, nil, vim.fn.input("Log point message: "), true)
  end
)
set("n", "<leader>dr", function() dap.repl.toggle({ height = 15 }) end)
set("n", "<leader>dl", dap.run_last)
set("n", "<leader>dj", dap.down)
set("n", "<leader>dk", dap.up)
set("n", "<leader>dc", dap.run_to_cursor)
set("n", "<leader>dS", function() widgets.centered_float(widgets.frames) end)
set("n", "<leader>dt", function() widgets.centered_float(widgets.threads) end)
set("n", "<leader>ds", function() widgets.centered_float(widgets.scopes) end)
set("n", "<leader>dh", widgets.hover)
set(
  "v",
  "<leader>dh",
  [[<ESC><CMD>lua require'dap.ui.widgets'.hover(require("dap.utils").get_visual_selection_text)<CR>]]
)

dap.listeners.after.event_initialized["me.dap.keys"] = function()
  set("n", "<down>", dap.step_over)
  set("n", "<left>", dap.step_out)
  set("n", "<right>", dap.step_into)
end
local reset_keys = function()
  pcall(keymap.del, "n", "<down>")
  pcall(keymap.del, "n", "<left>")
  pcall(keymap.del, "n", "<right>")
end
dap.listeners.after.event_terminated["me.dap.keys"] = reset_keys
dap.listeners.after.disconnected["me.dap.keys"] = reset_keys

local sidebar = widgets.sidebar(widgets.scopes)
vim.api.nvim_create_user_command("DapSidebar", sidebar.toggle, { nargs = 0 })
vim.api.nvim_create_user_command(
  "DapBreakpoints",
  function() dap.list_breakpoints(true) end,
  { nargs = 0 }
)

dap.defaults.fallback.terminal_win_cmd = "tabnew"
-- dap.defaults.fallback.external_terminal = {
--   command = "/usr/bin/alacritty",
--   args = { "--hold", "-e" },
-- }
require("dap.ext.vscode").load_launchjs()
