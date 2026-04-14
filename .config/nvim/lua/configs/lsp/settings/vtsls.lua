local nvchad_lsp = require "nvchad.configs.lspconfig"

local settings = {
  referencesCodeLens = {
    enable = true,
    showOnAllFunctions = true,
  },
  inlayHints = {
    parameterNames = {
      enabled = "literals",
    },
    parameterTypes = {
      enabled = true,
    },
    variableTypes = {
      enabled = false,
    },
    propertyDeclarationTypes = {
      enabled = true,
    },
    functionLikeReturnTypes = {
      enabled = true,
    },
    enumMemberValues = {
      enabled = true,
    },
  },
}

return {
  on_init = nvchad_lsp.on_init,
  settings = {
    typescript = settings,
    javascript = settings,
  },
}
