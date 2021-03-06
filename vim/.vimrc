syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set nu

" expandtab
autocmd FileType python,json,yaml,qml,scheme,markdown set expandtab

" Tlist 的快捷键
map <F2> :Tlist <CR>
map <F3> :NERDTreeToggle <CR>

" NERDTree
let NERDTreeWinPos="right"
let NERDTreeShowBookmarks=1


"set lisp
function SetLisp()
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set lisp
endfunction
autocmd FileType scheme call SetLisp()
autocmd BufNewFile *.scm call setline(1, "#!/bin/scheme --script")

"vim-slime
let g:slime_target="vimterminal"
let g:slime_vimterminal_cmd="chezscheme"

"vim.lisp
let g:lisp_rainbow=6
let g:lisp_instring=""

let g:completor_python_binary = "/usr/bin/python3"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

autocmd BufNewFile * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
