return {
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<leader>gl",
        "<cmd>LazyGit<cr>",
        desc = "Open LazyGit",
      },
      {
        "<leader>gf",
        "<cmd>LazyGitFilter<cr>",
        desc = "Open LazyGitFilter",
      },
    },
    config = require "configs.plugins.lazygit",
  },
}
