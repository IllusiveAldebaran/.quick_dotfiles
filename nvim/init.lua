vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.listchars = { tab = ">-", trail = "." }

vim.opt.incsearch = true            -- search as characters are entered
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered


-- from lukesmith calcurse your calendar and to-do list on your terminal
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = "/tmp/calcurse*",
	command = "set filetype=markdown",
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = "~/.calcurse/notes/*",
	command = "set filetype=markdown",
})
-- autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
-- autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown


-- vimwiki prereqs
vim.opt.compatible = false
-- filetype plugin on
-- syntax on

vim.g.vimwiki_list = {
	{path = "~/Documents/diary"},
	{path = "~/Documents/Music"},
	{path = "~/Documents/PCards"},
	{path = "~/Documents/Work"},
	{path = "~/Documents/bowtie"}
	-- {path = "~/Documents/newpath", syntax = "markdown", ext = ".md"}
}

--  lua require("custom-functions")
--  lua require("maps")
--  lua require'colorizer'.setup()

--  for buffers
-- nnoremap gb :ls<CR>:b<Space>
vim.keymap.set("n", "gb", ":ls<CR>:b<Space>")
-- vim.keymap.set("n", "gb", ":ls<CR>:b<Space>", { silent = true })

-- " command Browsersync :!browser-sync start --server --files 
-- " command Browsersync :!browser-sync start --server --files *.html --startPath *.html & 
-- " example online form reddit
-- " nn <F6> <cmd>!browser-sync start --server --files "*.js, *.html, *.css"<CR>

--  normal/insert
--  <Plug>MarkdownPreview
--  <Plug>MarkdownPreviewStop
--  <Plug>MarkdownPreviewToggle
 
--  example
--  nmap <C-s> <Plug>MarkdownPreview
--  nmap <M-s> <Plug>MarkdownPreviewStop
--  nmap <C-p> <Plug>MarkdownPreviewToggle

-- elsa plugin attempt
-- let g:elsa_conceal = v:true
-- set.opt.conceallevel = 2

-- make sure transparent bg works
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- highlight Normal guibg=none
-- highlight NonText guibg=none
-- highlight Normal ctermbg=none
-- highlight NonText ctermbg=none

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("functions")
