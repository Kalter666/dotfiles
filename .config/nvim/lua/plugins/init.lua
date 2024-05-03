local overrides = require "configs.overrides"

return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "configs.null-ls"
        end,
      },
    },
    config = function()
      require "configs.lspconfig"
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "mg979/vim-visual-multi",
  },

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
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
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
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    cmd = "Codeium",
    config = function()
      require("codeium").setup {}
    end,
    lazy = false,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" },
        },
        TODO = { icon = " ", color = "info" },
        HACK = {
          icon = " ",
          color = "warning",
          alt = { "FUCK", "SHIT", "BAD" },
        },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      },
    },
    cmd = { "TodoTelescope", "TodoTrouble", "TodoQuickFix", "TodoLocList" },
    keys = {
      {
        "<leader>ft",
        "<cmd>TodoTelescope<cr>",
        desc = "Open TODOs",
      },
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
    end,
    lazy = false,
  },
  {
    "m-demare/hlargs.nvim",
    opts = { color = "#ffb86c" },
    event = { "BufReadPost" },
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
      config = function()
        require("telescope").load_extension "lazygit"
      end,
    },
  },
  {
    "ryanoasis/vim-devicons",
    config = true,
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
        silent = true,
      }
    end,
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
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension "import"
    end,
    keys = {
      {
        "<leader>im",
        "<cmd>Telescope import<cr>",
        desc = "Import",
      },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = true,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      always_trigger = true,
      floating_window = true,
      hint_enable = true,
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("fidget").setup(opts)
    end,
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
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    dependencies = { "rcarriga/nvim-notify" },
    config = function()
      require("sniprun").setup {
        -- your options
        display = { "NvimNotify" },
        display_options = {
          notification_timeout = 60, -- in seconds
        },
        live_mode_toggle = "enable",
        live_display = { "NvimNotify", "TerminalOk" },
        interpreter_options = {
          Rust_original = {
            compiler = "rustc",
          },
        },
      }
    end,
  },
  {
    "RRethy/vim-illuminate",
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
  },
}
