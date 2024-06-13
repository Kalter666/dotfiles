-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "clangd",
  "pyright",
  "angularls",
  "hls",
  "eslint",
  "ruff_lsp",
  "jsonls",
  "cmake",
  "zls",
  "gopls",
  "marksman",
  "yamlls",
  "typos_lsp",
  "dockerls",
  "docker_compose_language_service",
  "taplo",
  "tsserver",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
    inlay_hints = {
      enabled = true,
    },
  }
end
-- lsps with default config
