return {
  {
    "ryanoasis/vim-devicons",
    config = true,
  },
  {
    "m-demare/hlargs.nvim",
    opts = { color = "#ffb86c" },
    event = { "BufReadPost" },
  },
  {
    "petertriho/nvim-scrollbar",
    config = require "configs.plugins.scrollbar",
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = true,
  },
}
