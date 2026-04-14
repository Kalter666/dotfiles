return {
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = require "configs.plugins.crates",
  },
  {
    "mrcjkb/haskell-tools.nvim",
    ft = { "haskell", "cabal", "lhaskell", "cabalproject" },
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "terrastruct/d2-vim",
    ft = { "d2" },
    lazy = true,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    ft = "markdown",
    cmd = { "RenderMarkdown" },
    opts = require "configs.plugins.render_markdown",
  },
}
