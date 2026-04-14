local nvchad_lsp = require "nvchad.configs.lspconfig"

return {
  on_attach = nvchad_lsp.on_attach,
  capabilities = nvchad_lsp.capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  inlay_hints = {
    enabled = true,
  },
}
