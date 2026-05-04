-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "clangd",
  "pyright",
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
  "rust_analyzer",
  "vtsls",
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
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
  })
end
-- lsps with default config

local vtslsSettings = {
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

vim.lsp.config("vtsls", {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
  settings = {
    typescript = vtslsSettings,
    javascript = vtslsSettings,
  },
})

-- local tsSettings = {
--   init_options = {
--     preferences = {
--       -- other preferences...
--       importModuleSpecifierPreference = "relative",
--       importModuleSpecifierEnding = "minimal",
--     },
--   },
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

-- vim.lsp.config("ts_ls", {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   on_init = on_init,
--   settings = {
--     typescript = tsSettings,
--     javascript = tsSettings,
--   },
-- })

vim.lsp.config("rust_analyzer", {
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
})

local angular_root = function(bufnr, on_dir)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local root = vim.fs.root(fname, { "angular.json" })

  if root then
    on_dir(root)
  end
end

vim.lsp.config("angularls", {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,

  root_dir = angular_root,

  inlay_hints = {
    enabled = true,
  },
})

vim.lsp.enable(vim.list_extend(servers, {
  "angularls",
}))

