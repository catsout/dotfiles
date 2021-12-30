set encoding=utf-8
set runtimepath+=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$XDG_CONFIG_HOME/vim/ftplugin
set packpath+=$XDG_CONFIG_HOME/vim
set viminfo+=n$XDG_CONFIG_HOME/vim/viminfo

syntax on
filetype plugin on

source $XDG_CONFIG_HOME/vim/coc.vim

lua require('init')

" default
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set nu

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo sh -c "cat > %"

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2

" lisp
autocmd FileType scheme setlocal ts=2 sts=2 sw=2 lisp
autocmd BufNewFile *.scm call setline(1, "#!/bin/scheme --script")

" expandtab
autocmd FileType xml,python,json,yaml,qml,scheme,markdown set expandtab

" 快捷键
map <F2> :Tlist <CR>
map <F3> :NERDTreeToggle <CR>
map <leader>f :Fold <CR> 

" indentLine https://github.com/Yggdroot/indentLine/issues/140
let g:vim_json_conceal = 0

" coc.nvim
let g:coc_config_home="$XDG_CONFIG_HOME/vim"
let g:coc_data_home="$XDG_DATA_HOME/coc"

" NERDTree
let NERDTreeWinPos="right"
let NERDTreeShowBookmarks=1
" NERDCommenter
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }


"vim-slime
let g:slime_target="vimterminal"
let g:slime_vimterminal_cmd="chezscheme"

"vim.lisp
let g:lisp_rainbow=6
let g:lisp_instring=""

let g:completor_python_binary = "/usr/bin/python3"

"bash-ftplugin
let g:is_bash=1
let g:sh_fold_enabled=3

autocmd BufNewFile * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
