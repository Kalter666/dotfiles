local M = {}

function M.setup()
  local nvchad_lsp = require "nvchad.configs.lspconfig"
  local common = require "configs.lsp.common"
  local servers = require "configs.lsp.servers"

  nvchad_lsp.defaults()

  for _, server in ipairs(servers) do
    vim.lsp.config(server, common)
  end

  vim.lsp.config("vtsls", vim.tbl_deep_extend("force", common, require "configs.lsp.settings.vtsls"))
  vim.lsp.config(
    "rust_analyzer",
    vim.tbl_deep_extend("force", common, require "configs.lsp.settings.rust_analyzer")
  )

  vim.lsp.enable(servers)
end

return M
