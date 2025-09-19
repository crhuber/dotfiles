let mapleader = " "

:set number
:set autoindent
:set tabstop=4       " number of visual spaces per TAB
:set softtabstop=4   " number of spaces in tab when editing
:set expandtab       " tabs are spaces
:set mouse=a
" Display different types of white spaces.
:set list
:set listchars=space:·,tab:->\
:set fixendofline

" Encoding
:set encoding=utf-8


call plug#begin()

Plug 'folke/tokyonight.nvim'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'
" Neo-tree and its dependencies
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'MagicDuck/grug-far.nvim' " Find and replace
Plug 'kdheepak/lazygit.nvim'


call plug#end()

colo tokyonight

" Neo-tree configuration
lua << EOF
require("neo-tree").setup({
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
    -- Add preview configuration
  preview = {
    enabled = true,
    preview_config = {
      -- Width of the preview window (percentage or absolute)
      width = 50,
      -- Height of the preview window (percentage or absolute)
      height = 20,
      -- Border style
      border = "rounded",
    },
  },
  window = {
    position = "left",
    width = 30,
    mappings = {
      ["|"] = "open_vsplit",        -- vertical split
      ["-"] = "open_split",         -- horizontal split
      ["<cr>"] = "open",            -- open in current window
      ["t"] = "open_tabnew",        -- open in new tab
      -- Preview mappings
      ["P"] = "toggle_preview",     -- Toggle floating preview
      ["<tab>"] = "preview",        -- Show preview (doesn't toggle)
      ["<S-tab>"] = "focus_preview", -- Focus the preview window
    }
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    -- Keep neo-tree rooted to current working directory
    follow_current_file = {
      enabled = true,  -- auto-navigate to current file
    },
    use_libuv_file_watcher = true,
    bind_to_cwd = true,  -- Bind to current working directory
  },
  -- Keep neo-tree open across tabs
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.cmd("setlocal number")
      end,
    }
  }
})
EOF

" Leader key mappings
nnoremap <leader>e :Neotree toggle<CR>
nnoremap <leader><Tab> :Neotree focus<CR> " toggle focus to neo tree

" Auto-open neo-tree on startup
"autocmd VimEnter * Neotree show

" Auto-open neo-tree at the file's directory if a file is opened
autocmd VimEnter * if expand('%:p') != '' | execute 'Neotree dir=' . expand('%:p:h') | else | Neotree show | endif


" Fuzzy file finding
nnoremap <leader><space> :Telescope find_files<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Rg<CR>

" File save
nnoremap <leader>w :w<CR>

" Window splits
nnoremap <leader>- :split<CR>
nnoremap <leader>\| :vsplit<CR>
nnoremap <leader>wd :close<CR>


" Better split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Trim trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" lualine
lua << END
require('lualine').setup()
END

" tab bar bufferline
set termguicolors
lua << EOF
require("bufferline").setup{}
EOF

" Tab management mappings
nnoremap <leader>tc :tabclose<CR>       " Close current tab
nnoremap <leader>to :tabonly<CR>        " Close all other tabs
nnoremap <leader>tn :tabnew<CR>         " New tab
nnoremap <leader>tt :tabnext<CR>        " Next tab
nnoremap <leader>tp :tabprevious<CR>    " Previous tab

" LazyVim-style search keybindings
nnoremap <leader>sg :Telescope live_grep<CR>
nnoremap <leader>sw :Telescope grep_string<CR>

" LazyVim-style search and replace keybindings with grug-far
nnoremap <leader>sr :lua require('grug-far').open()<CR>
vnoremap <leader>sr <esc>:lua require('grug-far').with_visual_selection()<CR>
"nnoremap <leader>sw :lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })<CR>

" Keybinding to open Lazygit in a floating terminal
nnoremap <leader>gg :lua require('lazygit').lazygit()<CR>


" grug-far minimal configuration
lua << EOF
require('grug-far').setup({
  engines = {
    ripgrep = {
      path = 'rg',
    },
  },
  engine = 'ripgrep',
})
EOF


" Telescope configuration
lua << EOF
require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--text',
    },
  }
})
EOF
