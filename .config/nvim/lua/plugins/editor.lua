return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = require "configs.plugins.better_escape",
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTelescope", "TodoTrouble", "TodoQuickFix", "TodoLocList" },
    keys = {
      {
        "<leader>ft",
        "<cmd>TodoTelescope<cr>",
        desc = "Open TODOs",
      },
    },
    config = require "configs.plugins.todo_comments",
    lazy = false,
  },
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>cr",
        function()
          require("ssr").open()
        end,
        mode = { "n", "v" },
        desc = "Advanced Replace",
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },
    config = require "configs.plugins.grug_far",
  },
  {
    "RRethy/vim-illuminate",
  },
}
