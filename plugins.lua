local plugins = {
  -- {
  --   "nvimdev/guard.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require "custom.configs.guard"
  --   end
  -- },
  {
    "akinsho/git-conflict.nvim",
    lazy = false,
    version = "*",
    config = true,
    opts = {
      default_mapping = false,
      disable_diagnostics = false,
    }
  },
  {
    "LintaoAmons/bookmarks.nvim",
    lazy = false,
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "stevearc/dressing.nvim" }
    }
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    requires = {
      "nvim-lua./plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = true,
  },
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = 'Silicon',
    config = function()
      require("silicon").setup({
        font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34"
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "LudoPinelli/comment-box.nvim",
    lazy = false,
    config = function()
      require("custom.configs.comment-divider")
    end
  },
  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require "custom.configs.tabout"
    end,
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp"
    }
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- require "custom.configs.dap"
      require("core.utils").load_mappings("dap")
    end
  },
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   ft = "python",
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --     "rcarriga/nvim-dap-ui",
  --   },
  --   config = function(_, _)
  --     local path = "python3"
  --     require("dap-python").setup(path)
  --     require("core.utils").load_mappings("dap_python")
  --   end
  -- },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "Civitasv/cmake-tools.nvim",
    opts = {},
    config = function()
      require "custom.configs.cmake-tools"
    end,
    event = "VeryLazy"
  },
  {
    "folke/neodev.nvim",
    opts = {
      library = {
        plugins = { "neotest" },
        types = true,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    config = function()
      require "custom.configs.neotest"
    end,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-plenary",
      "alfaix/neotest-gtest",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle test summary" },
      { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "Run nearest test" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show test output" },
    }
  },
  {
    "rbong/vim-flog",
    opts = {
      ensure_installed = {
        "tpope/vim-fugitive",
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    }
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact"
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Lua
        "lua-language-server",
        -- CSS
        "tailwindcss-language-server",
        -- JS/TS
        "typescript-language-server",
        "eslint-lsp",
        "prettierd",
        "js-debug-adapter",
        -- C/C++
        "clangd",
        "clang-format",
        "codelldb",
        "cmakelang",
        "cmakelint",
        "cmake-language-server",
        -- Python
        "debugpy",
        "black",
        "mypy",
        "ruff-lsp",
        "pyright",
        -- GO Lang
        "gopls",
        -- Prisma
        "prisma-language-server"
      }
    }
  }
}
return plugins
