set nocompatible               " be iMproved
filetype off                   " required!

set runtimepath=~/.vim/bundle/vundle/,~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'bdd/vim-scala'
" vim-scripts repos
Bundle 'xoria256.vim'
Bundle 'peaksea'
Bundle 'Markdown'
" non github repos

filetype plugin indent on     " required! 

set nobackup
set nowritebackup
set noswapfile
set viminfo=""

set number

set smartindent
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap \q :nohlsearch<CR>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set guifont=Dina\ 12
set t_Co=256
set mouse=a
set background=dark

set cm=blowfish

"cycle between buffers with C-n and C-p
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

"open ctrlp.vim buffer with ;
nmap ; :CtrlPBuffer<CR>

syntax enable
colorscheme xoria256

autocmd FileType html :setlocal sw=2 ts=2 sts=2

au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.gradle setf groovy

set grepprg=grep\ -nH\ $*
let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'xelatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf= 'zathura'
let g:Tex_MultipleCompileFormats = 'pdf,dvi'
