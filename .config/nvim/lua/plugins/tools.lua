return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
    },
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>im",
        "<cmd>Telescope import<cr>",
        desc = "Import",
      },
    },
    config = require "configs.plugins.telescope_import",
  },
  {
    "michaelb/sniprun",
    branch = "master",
    cmd = { "SnipRun", "SnipLive", "SnipRunOperator" },
    build = "sh install.sh",
    keys = {
      { "<leader>rs", "<cmd>SnipRun<cr>", mode = "n", desc = "Run SnipRun" },
      { "<leader>r", "<cmd>'<,'>SnipRun<cr>", mode = "v", desc = "Run SnipRun" },
    },
    dependencies = { "rcarriga/nvim-notify" },
    config = require "configs.plugins.sniprun",
  },
}
