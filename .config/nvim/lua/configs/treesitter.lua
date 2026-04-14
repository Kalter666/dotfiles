local base = require "nvchad.configs.treesitter"

return vim.tbl_deep_extend("force", base, {
  auto_install = true,
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "rust",
    "zig",
    "jsdoc",
    "comment",
    "ispc",
  },
  indent = {
    enable = true,
  },
})
