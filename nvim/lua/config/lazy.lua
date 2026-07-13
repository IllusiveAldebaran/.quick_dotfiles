local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  {
    "https://github.com/AndrewRadev/linediff.vim",
  },
  -- fzf: fuzzy finder
  {
    "https://github.com/junegunn/fzf.vim",
    dependencies = {
      "https://github.com/junegunn/fzf",
    },
    keys = {
      { "<Leader><Leader>", "<Cmd>Files<CR>",   desc = "Find files" },
      { "<Leader>,",        "<Cmd>Buffers<CR>", desc = "Find buffers" },
      { "<Leader>/",        "<Cmd>Rg<CR>",      desc = "Search project" },
    },
  },
  {
    "https://github.com/stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
    keys = {
      { "-", "<Cmd>Oil<CR>", desc = "Browse files from here" },
    },
  },
  -- vimwiki
  {
    "https://github.com/vimwiki/vimwiki",
  },
  {
    "https://github.com/vivaansinghvi07/cellular-automaton.nvim",
  },
  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "https://github.com/numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },
  -- vim-sleuth will try to guess correct indentation for some languages
  {
    "https://github.com/tpope/vim-sleuth",
    event = { "BufReadPost", "BufNewFile" },
  },
  -- Icons (used by lualine, alpha, etc.)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  -- Statusline
  {
    "https://github.com/nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },
  -- Keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },
  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install({
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      })
    end,
  },
  -- Mason: manages LSP servers, formatters, linters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "bashls" },
        automatic_installation = true,
      })
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("*", { capabilities = capabilities })
      vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "bashls" })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
      vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
    end,
  },
  -- Completion
  {
    "saghen/blink.cmp",
    version = "v0.*",
    opts = {
      keymap = { preset = "default" },
      appearance = { use_nvim_cmp_as_default = true },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters_by_ft = {
          lua        = { "stylua" },
          python     = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
        },
      })
    end,
  },
  -- AI coding tool
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
              },
            })
          end,
        },
        http = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "ANTHROPIC_API_KEY",
              },
            })
          end,
        },
      },

      interactions = {
        -- Chat buffer (:CodeCompanionChat) -- ACP-backed, talks to your real
        -- Claude Code session (skills, MCP servers, project memory all included)
        chat = {
          adapter = "claude_code",
        },

        -- CLI wrapper (:CodeCompanionCLI) -- this is a *separate* config table
        -- from adapters.acp, even though the name overlaps. It just wraps your
        -- normal `claude` terminal session in a Neovim buffer.
        cli = {
          agent = "claude_code",
          agents = {
            claude_code = {
              cmd = "claude",
              args = {},
              description = "Claude Code CLI",
              provider = "terminal",
            },
          },
        },

        -- Inline (:CodeCompanion) — ACP isn't supported here, so this needs
        -- an HTTP adapter hitting the Anthropic API directly.
        inline = {
          adapter = {
            name = "anthropic",
            model = "claude-sonnet-4-6",
          },
        },

        -- Cmd (:CodeCompanionCmd) — same restriction, HTTP adapter only.
        cmd = {
          adapter = {
            name = "anthropic",
            model = "claude-haiku-4-5-20251001",
          },
        },

        -- Background tasks (title generation, compaction, etc.) — cheap/fast
        -- model recommended since this runs automatically and often.
        background = {
          adapter = {
            name = "anthropic",
            model = "claude-haiku-4-5-20251001",
          },
        },
      },

      opts = {
        log_level = "INFO",
      },
    },
  },
})
