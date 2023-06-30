vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

local nnoremap = require("keymap").nnoremap
local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/cody/.local/share/eclipse/" .. project_name

-- some generic keybinds
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  nnoremap("K", vim.lsp.buf.hover, bufopts)
  nnoremap("gd", vim.lsp.buf.definition, bufopts) -- zero means current buffer
  nnoremap("gs", vim.lsp.buf.signature_help, bufopts)
  nnoremap("gi", vim.lsp.buf.implementation, bufopts)
  nnoremap("gr", vim.lsp.buf.references, bufopts)
  nnoremap("<leader>r", vim.lsp.buf.code_action, bufopts)
  nnoremap("<leader>gf", vim.diagnostic.open_float, bufopts)
  nnoremap("<leader>gj", vim.diagnostic.goto_next, bufopts)
  nnoremap("<leader>gk", vim.diagnostic.goto_prev, bufopts)
  nnoremap("<leader>D", vim.lsp.buf.type_definition, bufopts)
  nnoremap("grr", vim.lsp.buf.rename, bufopts)
  nnoremap("<A-o>", jdtls.organize_imports, bufopts)

  nnoremap("<leader>dn", jdtls.test_nearest_method, bufopts)
  vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)

  require("jdtls").setup_dap({ hotcodreplace = "auto" })
  require("jdtls.setup").add_commands()
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
extendedClientCapabilities.actionableNotificationSupported = true
extendedClientCapabilities.progressReportProvider = false

-- local bundles = {
--   vim.fn.glob("/opt/java-debug/com.microsoft.java.debug.plugin-0.44.0.jar", 1),
-- }

-- vim.list_extend(
--   bundles,
--   vim.split(vim.fn.glob("/opt/vscode-java-test/*jar", 1), "\n")
-- )

local config = {
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      format = {
        enabled = true,
        settings = {
          profile = "GoogleStyle",
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },
      telemetry = {
        enabled = false,
      },
    },
  },
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-noverify",
    "-Xmx4G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    "/opt/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration",
    "/opt/eclipse.jdt.ls/config_linux",
    "-data",
    workspace_dir,
  },
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = vim.fs.dirname(
    vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]
  ),
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  },
  handlers = {
    ["language/status"] = function() end,
  },
}

require("jdtls").start_or_attach(config)
require("fidget").setup({
  text = {
    spinner = "flip", -- animation shown when tasks are ongoing
    done = "", -- character shown when all tasks are complete
    commenced = "Started", -- message shown when task starts
    completed = "Completed", -- message shown when task completes
  },
  align = {
    bottom = true, -- align fidgets along bottom edge of buffer
    right = true, -- align fidgets along right edge of buffer
  },
  timer = {
    spinner_rate = 60, -- frame rate of spinner animation, in ms
    fidget_decay = 2000, -- how long to keep around empty fidget, in ms
    task_decay = 1000, -- how long to keep around completed task, in ms
  },
  window = {
    relative = "editor", -- where to anchor, either "win" or "editor"
    blend = 0, -- &winblend for the window
    zindex = 10, -- the zindex value for the window
  },
  fmt = {
    leftpad = true, -- right-justify text in fidget box
    stack_upwards = true, -- list of tasks grows upwards
    max_width = 0, -- maximum width of the fidget box
    -- function to format fidget title
    fidget = function(fidget_name, spinner)
      return string.format("%s %s", spinner, fidget_name)
    end,
    -- function to format each task line
    task = function(task_name, message, percentage)
      return string.format(
        "%s%s [%s]",
        message,
        percentage and string.format(" (%s%%)", percentage) or "",
        task_name
      )
    end,
  },
  debug = {
    logging = false, -- whether to enable logging, for debugging
  },
})

nnoremap("<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
nnoremap(
  "<leader>bc",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>"
)

nnoremap(
  "<leader>bl",
  "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>"
)
nnoremap("<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
nnoremap("<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>")

nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>")

nnoremap("<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
nnoremap("<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
nnoremap("<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
nnoremap("<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>")
nnoremap("<leader>dt", "<cmd>lua require'dap'.terminate()<cr>")
nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle({height=15})<cr>")
nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
nnoremap("<leader>di", function() require("dap.ui.widgets").hover() end)
nnoremap("<leader>d?", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end)
nnoremap("<leader>df", "<cmd>Telescope dap frames<cr>")
nnoremap("<leader>dh", "<cmd>Telescope dap commands<cr>")
nnoremap("<leader>dv", "<cmd>Telescope dap variables<cr>")
