filetype off

call plug#begin('~/.vim/bundle')

" Utilities
Plug 'bling/vim-airline' " Install airline
Plug 'scrooloose/syntastic' " Syntax checking
Plug 'tpope/vim-fugitive' " Git wrapper for VIM
Plug 'tpope/vim-eunuch' " Unix sugar for VIM
Plug 'tpope/vim-commentary' " Easy commenting
Plug 'tpope/vim-rails' " Rails stuffs
Plug 'mattn/emmet-vim' " Emmet, for fast code snippets and completions
Plug 'edkolev/tmuxline.vim' " Install Tmuxline

" Workflow
Plug 'kien/ctrlp.vim' " Fuzzy file finder
Plug 'ervandew/supertab' " Vim insert mode autocompletions
Plug 'nathanaelkane/vim-indent-guides' " Makes visually displaying indent levels easier
Plug 'christoomey/vim-tmux-navigator' " Because this shit gets confusing
Plug 'tpope/vim-vinegar' " Netrw enhancements 

" Markup
Plug 'tpope/vim-liquid' " Liquid syntax coloring
Plug 'vim-ruby/vim-ruby' "Rubish
Plug 'othree/html5.vim' " HTML5 Omnicomplete
Plug 'nono/vim-handlebars' " Syntax set for Handle Bars Templates
Plug 'pangloss/vim-javascript' " JS Markup and Syntax Support for VIM
Plug 'tpope/vim-surround' " Quoting/parenthesizing made simple
Plug 'scrooloose/nerdcommenter' " Commenting plugin
Plug 'tpope/vim-endwise' " Automatically add ruby end structures

" Theming
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

call plug#end()
filetype plugin indent on

" Settings

colorscheme jellybeans

autocmd VimResized * :wincmd =

" Disable arrow keys to force better vim navigation
map <up> <Nop>
map <down> <Nop>
map <left> <Nop>
map <right> <Nop>
noremap Q <Nop>
noremap K <Nop>

" Key Mappings
let mapleader=" " " Set leader to space
inoremap jj <ESC>
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>
nmap <leader>bq :bp <BAR> bd #<cr>
nmap <leader>bl :ls<cr>
map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>gg :Gbrowse<cr>
map <leader>gb :Gblame<cr>
map <leader>gd :Gdiff<cr>
nmap <leader>p :CtrlP<cr>
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Set Options
set autoindent " Turn auto indent on
set background=dark
set copyindent " Keep indents from previous lines
set colorcolumn=80 " Highlight columns after 80 characters
set cursorline " Highlight current line
set encoding=utf-8 " Set encoding
set expandtab
set fillchars+=stl:\ ,stlnc:\
set guifont=Inconsolata\ for\ Powerline:h15
set history=200 " Keep history for last 200 actions
set hlsearch " Highlight search
set ignorecase " Ignore case while searching
set incsearch " Incremental searching
set laststatus=2 " Always show status line
set lazyredraw " buffer screen updates
set matchtime=0
set noswapfile
set nowrap " Don't wrap lines
set number " Show line numbers
set shiftround " Indent by multiple of shiftwidth
set shiftwidth=2 " Spaces per tab
set showmatch " Shows the matching bracket for the one under the current cursor
set smartcase " If case is used in search, use it
set smarttab " Tab according to shiftwidth
set so=999 " Keep the cursor in the middle of the screen when possible.
set splitbelow " Always split windows under current
set splitright " Always split to the right of current
set t_Co=256 " Use 256 colors for Solarized
set tabstop=2 " Set number of columns for a tab
set termencoding=utf8 " Set encoding of terminal. This isn't actually good for terminals that don't support utf-8
set title " Set the title
set ttyfast
set undolevels=500 " Undo up to 500 times
set wildmenu " Tab for autocompletion of commands

syntax enable " Turn on syntax highlighting

let g:netrw_dirhistmax = 0


" Plugin Settings

" Syntastic
let g:syntastic_check_on_open = 1 " Check syntax of a file on open
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_stl_format = " %E{Err: %e}%B{, }%W{Warn: %w}"

" Fugitive
set diffopt+=vertical

" Powerline
let g:airline_theme = "jellybeans"
let g:airline_powerline_fonts = 1 " Set powerline symbols

let g:airline_section_z = "%#__accent_bold#%l%#__restore__#:%c"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extension#syntax#enabled = 1

" CtrlP
let g:ctrlp_custom_ignore = {
	\ 'dir': 	'\v[\/](\.(git|hg|svn)|\_site)$',
	\ 'file':  '\v\.(exe|so|dll|class|dmg|png|jpg|jpeg|tar.gz|zip)$',
	\}
"
"" Disable chacing
let g:ctrlp_use_caching=0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
endif

" Indent Guides
let g:indent_guides_guide_size = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_start_level = 2
