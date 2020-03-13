"""""" Mandtaory vim commands
set nocompatible
set nowrap
set encoding=utf-8
set noshowmode

"""""""""" Plugin Managment
call plug#begin('~/.config/nvim/plugged')

" Text Editing Plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-expand-region'
Plug 'godlygeek/tabular'
Plug 'wellle/targets.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'simnalamburt/vim-mundo'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'terryma/vim-multiple-cursors'

" IDE-like features
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'metakirby5/codi.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
Plug 'mklabs/split-term.vim'
Plug 'Shougo/echodoc.vim'
Plug 'sbdchd/vim-run'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-eunuch'

" Web Development
Plug 'gko/vim-coloresque'
Plug 'mattn/emmet-vim'
Plug 'turbio/bracey.vim'

" Note taking plugins
Plug 'dhruvasagar/vim-table-mode'
Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'
Plug 'shime/vim-livedown'
Plug 'vim-pandoc/vim-pandoc'

" Nice to haves
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'yuttie/comfortable-motion.vim'

" Themeing
Plug 'vim-airline/vim-airline'
Plug 'ayu-theme/ayu-vim'
Plug 'ayu-theme/ayu-vim-airline'
Plug 'ryanoasis/vim-devicons'

call plug#end()

"""""""""" Neovim Configurations

" Show line numbers
set number
set relativenumber
"set ruler

" Enable syntax highlighting
syntax on

" Set tabbing
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

"Handle long lines
set wrap
set textwidth=79
set formatoptions=qrn1

" Mouse control
set mouse=a

" Highlight current line
"set cursorline

set undofile
set undodir=~/.config/nvim/undo

set clipboard+=unnamedplus

"""""""""" Themeing
set t_Co=256
set termguicolors
let ayucolor="dark"
colorscheme ayu
highlight Normal guibg=NONE ctermbg=NONE
set foldmethod=indent
set foldlevel=99


let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

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

"let g:airline#extensions#tabline#enabled = 1

" indentline customization 
let g:indentLine_char = '▏'

let g:NERDTreeChDirMode = 2 

let g:fzf_nvim_statusline = 0

"""""""""" Compilers

let g:vim_run_command_map = {
  \'javascript': 'node',
  \'php': 'php',
  \'python': 'python',
  \'sh': 'bash -c',
  \'C' : 'gcc',
  \}


"""""""""" Documentation
let g:echodoc_enable_at_startup = 1

"""""""""" Key Mappings
let mapleader=","

" Vimfiler
nmap <leader>vf :NERDTreeToggle<cr> 

" Open/Close location list
nmap <leader>lc :lclose<cr>
nmap <leader>lo :lopen<cr>

" Open tagbar list
nmap <leader>ct :Vista!!<CR>

" Open Terminal
set splitbelow
nmap <leader>zs :10Term<cr>

" Tab Completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Run File
map <silent> <F5> :Run <cr>

" Fugitive commands
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gp :Gpush<cr>
nmap <leader>gP :Gpull<cr>

" Comfortable Motion shortcuts
noremap <silent> <PageUp> :call comfortable_motion#flick(-100)<CR>
noremap <silent> <PageDown>   :call comfortable_motion#flick(100)<CR>

