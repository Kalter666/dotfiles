-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.mason = {
  pkgs = {
    "lua-language-server",
    "stylua",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "json-lsp",
    "eslint-lsp",
    "buf",
    "protols",
    "clang-format",
    "rust-analyzer",
    "selene",
    "sqlfluff",
    "haskell-language-server",
    "pyright",
    "mypy",
    "zls",
    "ruff",
    "shellcheck",
    "vacuum",
    "actionlint",
    "cpplint",
    "hadolint",
    "markdownlint",
    "marksman",
    "revive",
    "stylelint",
    "cmake-language-server",
    "yaml-language-server",
    "gopls",
    "angular-language-server",
    "typos-lsp",
    "dockerfile-language-server",
    "docker-compose-language-service",
    "taplo",
    "vtsls",
  },
}

return M
