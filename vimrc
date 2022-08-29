set relativenumber
set noshowcmd
set clipboard=unnamed
set hidden
set expandtab
set softtabstop=2
set shiftwidth=2
set nowrap
set nocursorline
set noruler
set cmdheight=1
set splitbelow
set splitright
set ignorecase
set smartcase
set autoread
set number
set nojoinspaces

let mapleader=" "
nnoremap <SPACE> <Nop>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap Y y$

imap jj <Esc>
imap jk <Esc>

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation
nnoremap <silent> <leader>h :nohlsearch<CR>
nnoremap <silent> L :bn<CR>
nnoremap <silent> H :bp<CR>
nnoremap <silent> <leader>c :bd<CR>
