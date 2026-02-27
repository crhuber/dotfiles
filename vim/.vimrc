syntax on
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

set number          " show line numbers
set showcmd         " show command in bottom bar
set showmode        " show VIM mode
set cursorline      " highlight current line

set showmatch       " highlight matching [{()}]
set incsearch       " search as characters are entered
set hlsearch        " highlight matches

set showtabline=2   " show filename at top
set tabline=%t      " show only filename, not full path
" turn off search highlight by help of prressing
nnoremap <space> :nohlsearch<CR>

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
" space open/closes folds
nnoremap <leader>z za

" move vertically by visual line
nnoremap j gj
nnoremap k gk

set wildmenu        " visual autocomplete for command menu
filetype indent on      " load filetype-specific indent files

" Encoding
set encoding=utf-8

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.,space:·
set mouse=a " Enable mouse usage (all modes)

set belloff=all

" ================ Scrolling ========================

set scrolloff=4         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Plugins ======================

call plug#begin()

" List your plugins here
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()


" Catppuccin theme
set termguicolors
let g:lightline = {'colorscheme': 'catppuccin_mocha'}
let g:airline_theme = 'catppuccin_mocha'
colorscheme catppuccin_mocha
highlight SpecialKey guifg=#45475a ctermfg=238
highlight EndOfBuffer guifg=#1e1e2e ctermfg=235

" NERDTree configuration
" autocmd VimEnter * NERDTree | wincmd p
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let NERDTreeShowHidden=1

" Always use system clipboard
set clipboard=unnamed

" Airline configuration
let g:airline_section_z = '%l/%L' " Display current line and total lines in the status bar
let g:airline_section_y = ''      " Disable showing utf-8 encoding in the status bar
let g:airline_section_c = ''      " Disable filename

