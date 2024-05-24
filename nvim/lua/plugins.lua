-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- dashboard
	use({
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("configs.dashboard")
		end,
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	-- hex color code display
	use("ap/vim-css-color")

	-- ELSA for CSE130, Lambda Calculus
	use("glapa-grossklag/elsa.vim")

	-- Common utilities
	use("nvim-lua/plenary.nvim")

	-- The next plugins, up to Auto Pairs, taken from https://dev.to/slydragonn/how-to-set-up-neovim-for-windows-and-linux-with-lua-and-packer-2391 (with some exceptions and edits)
	-- Colorschema
	use("rebelot/kanagawa.nvim")

	-- Icons
	use("nvim-tree/nvim-web-devicons")

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",
		config = function()
			require("configs.lualine")
		end,
		requires = { "nvim-web-devicons" },
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("configs.treesitter")
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lsp")
		end,
	})

	use("onsails/lspkind-nvim")
	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v<CurrentMajor>.*",
	})

	-- cmp: Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("configs.cmp")
		end,
	})

	use("hrsh7th/cmp-nvim-lsp")

	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

	-- LSP diagnostics, code actions, and more via Lua.
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("configs.null-ls")
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Mason: Portable package manager
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})

	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("configs.mason-lsp")
		end,
	})

	-- File manager
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	})

	-- Show colors
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	})

	-- Terminal
	-- use {"akinsho/toggleterm.nvim", tag = '*', config = function()
	--   require("toggleterm").setup()
	-- end}

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end,
	})

	-- Markdown Preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- Auto pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("configs.autopairs")
		end,
	})

	-- funny rain, game-of-life, slide, and other animation
	-- use 'eandrju/cellular-automaton.nvim'
	use("vivaansinghvi07/cellular-automaton.nvim")
	-- Dependency
	--  Commented out since already used
	-- use {
	--     'nvim-treesitter/nvim-treesitter',
	--     run = function()
	--         local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
	--         ts_update()
	--     end,
	-- }

	-- update session files. This is kind of old, but works in conjuction to keep tmux session files between reboots. Adds :Obsess
	use("tpope/vim-obsession")

	-- Auto pairs for '(' '[' '{'
	-- use 'jiangmiao/auto-pairs'
	-- Gets in the way more often than not lately. Assumes I want it when I am trying to place the around a word or sentence.

	-- LaTex for NeoVim
	use("lervag/vimtex")

	-- markdown preview
	-- install without yarn or npm
	-- This says it is installing twice, worth checking later?
	-- use({
	--     "iamcco/markdown-preview.nvim",
	--     run = function() vim.fn["mkdp#util#install"]() end,
	-- })
	-- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

	-- Comments for nvim (commented out because don't think it's very good)
	-- use 'terrortylor/nvim-comment'
	-- require('nvim_comment').setup()

	-- Simple plugins can be specified as strings
	--use 'rstacruz/vim-closer'

	-- Lazy loading:
	-- Load on specific commands
	use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

	-- Load on an autocommand event
	-- use {'andymass/vim-matchup', event = 'VimEnter'}

	-- Load on a combination of conditions: specific filetypes or commands
	-- Also run code after load (see the "config" key)
	-- use {
	--   'w0rp/ale',
	--   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
	--   cmd = 'ALEEnable',
	--   config = 'vim.cmd[[ALEEnable]]'
	-- }

	-- Plugins can have dependencies on other plugins
	-- use {
	--   'haorenW1025/completion-nvim',
	--   opt = true,
	--   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
	-- }

	-- Plugins can also depend on rocks from luarocks.org:
	-- use {
	--   'my/supercoolplugin',
	--   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
	-- }

	-- You can specify rocks in isolation
	-- use_rocks 'penlight'
	-- use_rocks {'lua-resty-http', 'lpeg'}

	-- Local plugins can be included
	-- use '~/projects/personal/hover.nvim'

	-- Plugins can have post-install/update hooks
	-- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

	-- Post-install/update hook with neovim command
	-- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- Post-install/update hook with call of vimscript function with argument
	-- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

	-- Use specific branch, dependency and run lua file after load
	-- use {
	--   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
	--   requires = {'kyazdani42/nvim-web-devicons'}
	-- }

	-- Use dependency and run lua function after load
	-- use {
	--   'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
	--   config = function() require('gitsigns').setup() end
	-- }

	-- You can specify multiple plugins in a single call
	-- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

	-- You can alias plugin names
	-- use {'dracula/vim', as = 'dracula'}
end)
