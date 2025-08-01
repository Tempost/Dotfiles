vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" })
local project_name = root_dir and vim.fs.basename(root_dir)
local cmd = { vim.fn.exepath("jdtls"), "-javaagent:", "/opt/eclipse.jdt.ls/lombok.jar" }

if project_name then
  local config_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
  local workspace = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"

  vim.list_extend(cmd, { "-configuration", config_dir, "-data", workspace })
end

local config = {
  cmd = cmd,
  root_dir = root_dir,
  project_name = project_name,
  settings = {
    java = {
      inlayints = {
        parameterNames = {
          enabled = "all",
        },
      },
    },
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_start_all_buffers", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    require("config.lsp").on_attach(client, args.buf)

    if client and client.name == "jdtls" then
      local map = vim.keymap.set
      map(
        "v",
        "<leader>cxm",
        [[<ESC><CMD>lua require("jdtls").extract_method({ visual = true })<CR>]],
        { buffer = args.buf, silent = true, desc = "Extract Method" }
      )
    end
  end,
})

require("jdtls").start_or_attach(config)
