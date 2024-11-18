local dap = require "dap"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "js-debug-adapter",
  },
}

dap.adapters["lldb"] = {
  type = "executable",
  command = "/usr/bin/lldb-vscode",
  name = "lldb",
}

local languages = {
  "typescript",
  "javascript",
  "rust",
}

dap.configurations["typescript"] = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    runtimeExecutable = "node",
  },
}

dap.configurations["javascript"] = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    runtimeExecutable = "node",
  },
}
