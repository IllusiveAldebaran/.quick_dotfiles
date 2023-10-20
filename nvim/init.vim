set nu
set rnu
set clipboard+=unnamedplus

set expandtab
set tabstop=2
set shiftwidth=2

lua require('plugins')

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
