return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = true },
      picker = {
        exclude = { "node_modules", ".git", ".venv" },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        ruff = {
          init_options = {
            settings = {
              args = {
                "--select=E,W,F,I,B,C4,UP,ARG001",
                "--ignore=E501,B008,W191,B904",
              },
            },
          },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "off",
              },
            },
          },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      file_ignore_patterns = {
        "node_modules/",
        "dist/",
        ".next/",
        ".git/",
        ".gitlab/",
        "build/",
        "target/",
        "package-lock.json",
        "pnpm-lock.yaml",
        "yarn.lock",
        "uv.lock",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", lsp_format = "first" },
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = { -- Default  Range
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.4      [0, 1]
      stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
      trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
      damping = 0.8, -- 0.65     [0, 1]
      damping_insert_mode = 0.8, -- 0.7      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
      time_interval = 7, -- milliseconds
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    opts = {
      prompt_func_param_type = {
        python = true,
      },
    },
  },
  --{
  --  "saghen/blink.cmp",
  --  opts = {
  --    fuzzy = { implementation = "lua" },
  --  },
  --},
}
