set nocompatible
filetype off

"initialise vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"initialise powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"plugins via vundle
Bundle 'gmarik/vundle'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
Bundle 'jnurmine/Zenburn'

filetype plugin indent on

"disable extraneous files
set nobackup
set nowritebackup
set noswapfile
set viminfo=""

"enable line numbers
set number

"colorscheme settings
set t_Co=256
syntax enable
colorscheme zenburn

"avoid moving around wrapped lines
nmap j gj
nmap k gk

"improve search highlighting
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap \q :nohlsearch<CR>

"ctrl-p.vim settings
nmap ; :CtrlPBuffer<CR>
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

"easy NERDTree binding
nmap \e :NERDTreeToggle<CR>

"dealing with tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>
