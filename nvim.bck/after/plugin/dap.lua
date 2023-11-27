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

dap.defaults.fallback.terminal_win_cmd = "tabnew"
require("dap.ext.vscode").load_launchjs()
