set encoding=utf-8

" Setup Python for Neovim
" ---------------------------------------------------------
let g:python_host_prog = '/usr/local/bin/python3'
let g:python3_host_prog = '/usr/local/bin/python3'

call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi',
Plug 'sbdchd/neoformat'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'editorconfig/editorconfig-vim'
Plug 'jremmen/vim-ripgrep'
Plug 'ludovicchabant/vim-gutentags'
Plug 'jreybert/vimagit'
Plug 'kshenoy/vim-signature'

Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-one'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Improved syntax highlighting
Plug 'sheerun/vim-polyglot'

call plug#end()

let mapleader="\<SPACE>"
set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set noswapfile
set cursorline

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set guifont=Dank\ Mono:s14

" Refresh file on focus
set autoread
au FocusGained * :checktime

" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces        

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

set clipboard=unnamed

if !&scrolloff
set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set nostartofline       " Do not jump to first character with page commands.
set nowrap              " Do not soft wrap long lines

set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.

" set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Use ; for commands instead of :
nnoremap ; :

" move by row, not by line (with reverse mappings)
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" More logical cut
nnoremap Y y$

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" map jj to esc
imap jj <Esc>

" Easier moving of code blocks
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Use Q to execute default register
nnoremap Q @q

" Clear highlighting
nnoremap <silent> c/ :nohlsearch<CR>

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" NERDTree shortcut
map <F2> :NERDTreeToggle<CR>

" ctrlP Settings
" Open file menu
nnoremap <Leader>o :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

" Use Esc to exit insert mode when in terminal
:tnoremap <Esc> <C-\><C-n>

" Window splits shortcuts
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" buffer previous/next shortcuts
nnoremap <silent> <leader>q :bp<CR>
nnoremap <silent> <leader>e :bn<CR>
nnoremap <silent> <leader>x :bd<CR>

" Close all buffers 
nnoremap <silent> <leader>bd :%bd<CR>

" CtrlP Custom ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$\|node_modules$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$\|\.pyc'
  \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Use deoplete for autocompletion
let g:deoplete#enable_at_startup = 1

let g:EditorConfig_exclude_patterns = ['fugitive://.*','scp://.*']

" ALE config
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_options = '-m flake8'
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 0

let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint']
\}

let g:ale_fixers = {
\   'python': ['yapf'],
\   'javascript': ['prettier'],
\   'css': ['prettier']
\}

nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

" Looks
set t_Co=256

colorscheme palenight

" Dark Theme 2
set background=dark
let g:airline_theme = 'ayu_dark'

" Light Theme
" set background=light
" let g:airline_theme = 'light'

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

let g:palenight_terminal_italics=1

hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

abbr breakpoint import ipdb; ipdb.set_trace(context=10)<esc>0
