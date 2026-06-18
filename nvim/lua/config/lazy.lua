local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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
  {
    "https://github.com/junegunn/fzf.vim",
    dependencies = {
      "https://github.com/junegunn/fzf",
    },
    keys = {
      { "<Leader><Leader>", "<Cmd>Files<CR>", desc = "Find files" },
      { "<Leader>,", "<Cmd>Buffers<CR>", desc = "Find buffers" },
      { "<Leader>/", "<Cmd>Rg<CR>", desc = "Search project" },
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
	-- use 'eandrju/cellular-automaton.nvim'
  {
    "https://github.com/vivaansinghvi07/cellular-automaton.nvim",
  },
  {
    "https://github.com/junegunn/fzf.vim",
    dependencies = {
      "https://github.com/junegunn/fzf",
    },
    keys = {
      { "<Leader><Leader>", "<Cmd>Files<CR>", desc = "Find files" },
      { "<Leader>,", "<Cmd>Buffers<CR>", desc = "Find buffers" },
      { "<Leader>/", "<Cmd>Rg<CR>", desc = "Search project" },
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
  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter", -- Only load when you enter Insert mode
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "https://github.com/numToStr/Comment.nvim",
    event = "VeryLazy", -- Special lazy.nvim event for things that can load later and are not important for the initial UI
    config = function()
      require("Comment").setup()
    end,
  },
  -- vim-sleuth will try to guess correct indentation for some languages
  {
    "https://github.com/tpope/vim-sleuth",
    event = { "BufReadPost", "BufNewFile" }, -- Load after your file content
  },
  -- Statusline
  {
    "https://github.com/nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      --require("configs.lualine")
      require("lualine").setup()
    end,
    requires = { "nvim-web-devicons" }, -- this line was like this in packer, don't know if it breaks thigns
  },
 --  {
 --    "https://github.com/VonHeikemen/lsp-zero.nvim",
 --    dependencies = {
 --      "https://github.com/williamboman/mason.nvim",
 --      "https://github.com/williamboman/mason-lspconfig.nvim",
 --      "https://github.com/neovim/nvim-lspconfig",
 --      "https://github.com/hrsh7th/cmp-nvim-lsp",
 --      "https://github.com/hrsh7th/nvim-cmp",
 --      "https://github.com/L3MON4D3/LuaSnip",
 --    },
 --    config = function()
 --      local lsp_zero = require('lsp-zero')
	--
 --      lsp_zero.on_attach(function(client, bufnr)
	-- lsp_zero.default_keymaps({buffer = bufnr})
 --      end)
	--
 --      require("mason").setup()
 --      require("mason-lspconfig").setup({
	-- ensure_installed = {
	--   -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	--   "gopls", -- Go
	--   "pyright", -- Python
	--   -- "rust_analyzer", -- Rust
	-- },
	-- handlers = {
	--   lsp_zero.default_setup,
	-- },
 --      })
 --    end,
 --  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPre", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
	"bash",
	"c",
	"diff",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
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
      },
      incremental_selection = {
	enable = true,
	keymaps = {
	  init_selection = "<C-space>",
	  node_incremental = "<C-space>",
	  scope_incremental = false,
	  node_decremental = "<bs>",
	},
      },
      textobjects = {
	move = {
	  enable = true,
	  goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
	  goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
	  goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
	  goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
	},
      },
    },
    ---@param opts TSConfig
    -- config = function(_, opts)
    --   if type(opts.ensure_installed) == "table" then
    --     opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    --   end
    --   require("nvim-treesitter.configs").setup(opts)
    -- end,
  },

  --   spec = {
  --     -- add LazyVim and import its plugins
  --     { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  --     -- import/override with your plugins
  --     { import = "plugins" },
  --   },
  --   defaults = {
  --     -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
  --     -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
  --     lazy = false,
  --     -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
  --     -- have outdated releases, which may break your Neovim install.
  --     version = false, -- always use the latest git commit
  --     -- version = "*", -- try installing the latest stable version for plugins that support semver
  --   },
  --   -- install = { colorscheme = { "tokyonight", "habamax" } },
  --   checker = {
  --     enabled = true, -- check for plugin updates periodically
  --     notify = false, -- notify on update
  --   }, -- automatically check for plugin updates
  --   performance = {
  --     rtp = {
  --       -- disable some rtp plugins
  --       disabled_plugins = {
  --         "gzip",
  --         -- "matchit",
  --         -- "matchparen",
  --         -- "netrwPlugin",
  --         "tarPlugin",
  --         "tohtml",
  --         "tutor",
  --         "zipPlugin",
  --       },
  --     },
  --   },
})
