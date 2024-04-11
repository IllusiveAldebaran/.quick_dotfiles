-- Copied from https://dev.to/slydragonn/how-to-set-up-neovim-for-windows-and-linux-with-lua-and-packer-2391
local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

ts.setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	ensure_installed = {
		"markdown",
		"tsx",
		"typescript",
		"javascript",
		"toml",
		"java",
		-- "latex", -- needs grammar def compatibile with nvim
		"llvm",
		"json",
		"yaml",
		"rust",
		"css",
		"html",
		"haskell",
		"elsa", -- manually added via glapa-grossklag/tree-sitter-elsa
		"bash",
		"lua",
		"printf",
		"python",
		"regex",
		"sql",
		"verilog", -- provides systemverilog
		"xml",
		"zathurarc",
		"arduino",
		"awk",
		"asm",
		"c",
		"cmake",
		"make",
		"cpp",
		"cuda",
		"doxygen",
		"gitignore",
		"git_config",
		"gpg",
		"gnuplot",
	},
	rainbow = {
		enable = true,
		disable = { "html" },
		extended_mode = false,
		max_file_lines = nil,
	},
	autotag = { enable = true },
	incremental_selection = { enable = true },
	indent = { enable = true },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
