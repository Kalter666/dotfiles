return {
  {
    "mason-org/mason.nvim",
    opts = require "configs.mason",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },
  { import = "nvchad.blink.lazyspec" },
}
