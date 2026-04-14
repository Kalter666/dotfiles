return {
  {
    "neovim/nvim-lspconfig",
    main = "configs.lsp",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "configs.null-ls"
        end,
      },
    },
    config = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    cmd = { "Lspsaga" },
    keys = {
      { "<leader>ln", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "LSP diagnostics jump next" },
      { "<leader>lp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "LSP diagnostics jump previous" },
      { "<leader>K", "<cmd>Lspsaga hover_doc<cr>", desc = "LSP hover documentation" },
      { "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "LSP rename" },
      { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "LSP code action" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = require "configs.plugins.lspsaga",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = require "configs.plugins.lsp_signature",
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = require "configs.plugins.fidget",
  },
  {
    "zeioth/none-ls-autoload.nvim",
    event = "BufEnter",
    dependencies = {
      "mason-org/mason.nvim",
      "zeioth/none-ls-external-sources.nvim",
    },
    opts = require "configs.lsp.none_ls_autoload",
  },
}
