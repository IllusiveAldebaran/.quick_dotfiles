set nu
set rnu
set clipboard+=unnamedplus

set expandtab
set tabstop=2
set shiftwidth=2

set incsearch " true            -- search as characters are entered
set ignorecase " true           -- ignore case in searches by default
set smartcase " true            -- but make it case sensitive if an uppercase is entered


lua require("custom-functions")
lua require('plugins')
lua require("maps")
set termguicolors
lua require'colorizer'.setup()

" for buffers
nnoremap gb :ls<CR>:b<Space>

" command Browsersync :!browser-sync start --server --files 
" command Browsersync :!browser-sync start --server --files *.html --startPath *.html & 
" example online form reddit
" nn <F6> <cmd>!browser-sync start --server --files "*.js, *.html, *.css"<CR>

" normal/insert
" <Plug>MarkdownPreview
" <Plug>MarkdownPreviewStop
" <Plug>MarkdownPreviewToggle

" example
" nmap <C-s> <Plug>MarkdownPreview
" nmap <M-s> <Plug>MarkdownPreviewStop
" nmap <C-p> <Plug>MarkdownPreviewToggle
