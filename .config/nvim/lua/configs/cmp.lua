local options = require "nvchad.configs.cmp"

options.sources = {
  { name = "nvim_lsp" },
  -- { name = "codeium" },
  { name = "luasnip" },
  { name = "buffer" },
  { name = "nvim_lua" },
  { name = "path" },
}

return options
