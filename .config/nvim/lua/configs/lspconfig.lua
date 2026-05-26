local nvchad_lsp = require "nvchad.configs.lspconfig"

local on_attach = nvchad_lsp.on_attach
local on_init = nvchad_lsp.on_init
local capabilities = nvchad_lsp.capabilities

nvchad_lsp.defaults()

local function with_defaults(config)
  return vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    inlay_hints = {
      enabled = true,
    },
  }, config or {})
end

local function with_attach(extra)
  return function(client, bufnr)
    on_attach(client, bufnr)
    extra(client, bufnr)
  end
end

local function ts_inlay_hints()
  return {
    parameterNames = { enabled = "literals" },
    parameterTypes = { enabled = true },
    variableTypes = { enabled = false },
    propertyDeclarationTypes = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
  }
end

local ts_preferences = {
  disableSuggestions = true,
  importModuleSpecifierPreference = "shortest",
  importModuleSpecifierEnding = "minimal",
  includePackageJsonAutoImports = "auto",
  quotePreference = "auto",
}

vim.lsp.config("vtsls", with_defaults {
  init_options = {
    hostInfo = "neovim",
  },
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      enableMoveToFileCodeAction = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      preferences = ts_preferences,
      suggest = {
        completeFunctionCalls = false,
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
      referencesCodeLens = {
        enabled = true,
        showOnAllFunctions = true,
      },
      inlayHints = ts_inlay_hints(),
    },
    javascript = {
      preferences = ts_preferences,
      suggest = {
        completeFunctionCalls = false,
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
      referencesCodeLens = {
        enabled = true,
        showOnAllFunctions = true,
      },
      inlayHints = ts_inlay_hints(),
    },
  },
})

vim.lsp.config("eslint", with_defaults {
  on_attach = with_attach(function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspEslintFixAll", function()
      client:request_sync("workspace/executeCommand", {
        command = "eslint.applyAllFixes",
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = vim.lsp.util.buf_versions[bufnr],
          },
        },
      }, nil, bufnr)
    end, {})
  end),
  settings = {
    validate = "on",
    packageManager = nil,
    useESLintClass = false,
    experimental = {},
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    format = false,
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    problems = {
      shortenToSingleLine = false,
    },
    nodePath = "",
    workingDirectory = {
      mode = "auto",
    },
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
})

vim.lsp.config("angularls", with_defaults {
  root_markers = { "angular.json", "nx.json" },
  filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
})

vim.lsp.config("html", with_defaults {
  settings = {
    html = {
      format = {
        templating = true,
        wrapLineLength = 120,
        wrapAttributes = "auto",
      },
      hover = {
        documentation = true,
        references = true,
      },
    },
  },
})

vim.lsp.config("cssls", with_defaults {
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

vim.lsp.config("jsonls", with_defaults {
  settings = {
    json = {
      validate = {
        enable = true,
      },
      format = {
        enable = true,
      },
    },
  },
})

vim.lsp.config("yamlls", with_defaults {
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      format = {
        enable = true,
      },
      schemaStore = {
        enable = true,
      },
      keyOrdering = false,
    },
  },
})

vim.lsp.config("pyright", with_defaults {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.config("ruff", with_defaults {
  on_attach = with_attach(function(client)
    client.server_capabilities.hoverProvider = false
  end),
  settings = {
    configurationPreference = "filesystemFirst",
  },
})

vim.lsp.config("rust_analyzer", with_defaults {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        buildScripts = {
          enable = true,
        },
      },
      check = {
        command = "clippy",
      },
      diagnostics = {
        enable = true,
      },
      procMacro = {
        enable = true,
      },
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

vim.lsp.config("gopls", with_defaults {
  settings = {
    gopls = {
      completeUnimported = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
      analyses = {
        fieldalignment = false,
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

vim.lsp.config("clangd", with_defaults {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
  },
  capabilities = vim.tbl_deep_extend("force", capabilities, {
    offsetEncoding = { "utf-16" },
  }),
})

vim.lsp.config("hls", with_defaults {
  filetypes = { "haskell", "lhaskell", "cabal" },
  settings = {
    haskell = {
      formattingProvider = "ormolu",
      cabalFormattingProvider = "cabal-fmt",
      checkParents = "CheckOnSave",
      plugin = {
        class = {
          codeActionsOn = true,
        },
        importLens = {
          codeLensOn = true,
        },
        rename = {
          config = {
            crossModule = true,
          },
        },
      },
    },
  },
})

vim.lsp.config("zls", with_defaults {
  settings = {
    zls = {
      enable_build_on_save = true,
      enable_inlay_hints = true,
      enable_snippets = true,
      warn_style = true,
    },
  },
})

vim.lsp.config("dockerls", with_defaults {
  settings = {
    docker = {
      languageserver = {
        formatter = {
          ignoreMultilineInstructions = true,
        },
      },
    },
  },
})

vim.lsp.config("docker_compose_language_service", with_defaults())

vim.lsp.config("cmake", with_defaults {
  settings = {
    cmake = {
      configureOnOpen = false,
    },
  },
})

vim.lsp.config("taplo", with_defaults {
  settings = {
    evenBetterToml = {
      schema = {
        enabled = true,
      },
    },
  },
})

vim.lsp.config("typos_lsp", with_defaults {
  settings = {
    typos = {
      diagnosticSeverity = "Info",
    },
  },
})

vim.lsp.config("marksman", with_defaults())
vim.lsp.config("protols", with_defaults())
vim.lsp.config("buf_ls", with_defaults())

vim.lsp.config("lua_ls", with_defaults {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = { "vim" },
      },
      hint = {
        enable = true,
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.enable {
  "angularls",
  "buf_ls",
  "clangd",
  "cmake",
  "cssls",
  "docker_compose_language_service",
  "dockerls",
  "eslint",
  "gopls",
  "hls",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "protols",
  "pyright",
  "ruff",
  "rust_analyzer",
  "taplo",
  "typos_lsp",
  "vtsls",
  "yamlls",
  "zls",
}
