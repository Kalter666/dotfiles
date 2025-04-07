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
  "ruff",
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

-- local vtslsSettings = {
--   referencesCodeLens = {
--     enable = true,
--     showOnAllFunctions = true,
--   },
--   inlayHints = {
--     parameterNames = {
--       enabled = "literals",
--     },
--     parameterTypes = {
--       enabled = true,
--     },
--     variableTypes = {
--       enabled = false,
--     },
--     propertyDeclarationTypes = {
--       enabled = true,
--     },
--     functionLikeReturnTypes = {
--       enabled = true,
--     },
--     enumMemberValues = {
--       enabled = true,
--     },
--   },
-- }
--
-- lspconfig.ts_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   on_init = on_init,
--   settings = {
--     typescript = vtslsSettings,
--     javascript = vtslsSettings,
--   },
-- }

local tsSettings = {
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

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
  settings = {
    typescript = tsSettings,
    javascript = tsSettings,
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    initializationOptions = {
      checkOnSave = true,
    },
  },
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        bindingModeHints = {
          enable = false,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = "never",
        },
        lifetimeElisionHints = {
          enable = "never",
          useParameterNames = false,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = "never",
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
    },
  },
}
