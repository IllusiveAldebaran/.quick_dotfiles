-- taken from https://dev.to/slydragonn/how-to-set-up-neovim-for-windows-and-linux-with-lua-and-packer-2391
local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

local status, telescope = pcall(require, "telescope.builtin")
if status then
	-- Telescope
	map("n", "<leader>ff", telescope.find_files)
	map("n", "<leader>fg", telescope.live_grep)
	map("n", "<leader>fb", telescope.buffers)
	map("n", "<leader>fh", telescope.help_tags)
	map("n", "<leader>fs", telescope.git_status)
	map("n", "<leader>fc", telescope.git_commits)
else
	print("Telescope not found")
end

-- Save
-- map("n", "<leader>w", "<CMD>update<CR>")

-- Quit
-- map("n", "<leader>q", "<CMD>q<CR>")

-- Exit insert mode
-- map("i", "jk", "<ESC>")

-- turn off autosuggestions (nvim-cmp I believe) (Suggestion Off)
map("n", "<leader>ta", "<CMD>lua require('cmp').setup.buffer { enabled = false }<CR>")

-- Windows
map("n", "<leader>|", "<CMD>vsplit<CR>")
map("n", "<leader>-", "<CMD>split<CR>")

-- toggle neovim status line on or off (toggle status)
map("n", "<leader>ts", ":lua ToggleStatusLine()<CR>")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>")
map("n", "<leader>o", "<CMD>Neotree focus<CR>")

-- Tabs
map("n", "<TAB>", "gt")
map("n", "<S-TAB>", "gT")

-- Terminal
map("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>")
map("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>")

-- Dumb git toggle left column
map("n", "<leader>tt", "<CMD>Gitsigns toggle_signs<CR>")

-- Markdown Preview
map("n", "<leader>m", "<CMD>MarkdownPreview<CR>")
map("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>")

-- Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Resize Windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")
