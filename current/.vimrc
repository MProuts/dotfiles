" ===================
" plugin installation
" ===================
" https://github.com/junegunn/vim-plug
"
" To install plugins:
" 1) source ~/.vimrc
" 2) :PlugInstall

call plug#begin('~/.vim/plugs')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/seoul256.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'nelstrom/vim-visual-star-search'

" Provides [b shortcuts for switching between buffers, args, etc
Plug 'tpope/vim-unimpaired'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
" Show lint errors in the gutter
" Plug 'dense-analysis/ale'
" Syntax highlighting
Plug 'sheerun/vim-polyglot'
" Show git diff in the gutter
" Plug 'airblade/vim-gitgutter'
" Colorscheme
Plug 'morhetz/gruvbox'
" COC (Conquer of Completion)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
" NOTE: ^ This section needs to be first since some of the configuration below
" depends on plugins being installed, e.g. colorscheme

" ======
" config
" ======

" backspacing
" -----------
" indent    allow backspacing over autoindent
" start     allow backspacing over the start of insert; CTRL-W and CTRL-U
"           stop once at the start of insert.
" eol       allow backspacing over line breaks (join lines)
set backspace=indent,eol,start

" swapfiles
" ---------
set wildignore+=*.swp,*~,._*    " disable temp and backup files
set backupdir^=~/.vim/_backup// " where to put backup files (must create this directory)
set directory^=~/.vim/_swap//   " where to put swap files (must create this directory)

" highlighting
" ------------
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" highlight search matches
set hlsearch
" clear search highlight
map <C-l> :let @/ = ""<CR>

" general
" -------
" turn on syntax highlighting and set colorscheme
syntax on
" colorscheme gruvbox
" let g:gruvbox_contrast_light='hard'
" let g:gruvbox_contrast_dark='hard'

colorscheme seoul256

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" show line numbers
set number
" suppress “No write since last change” message
set hidden
" wrap long lines
set wrap
" set max width for formatting
set textwidth=80
" attach the system clipboard to the unnamed register
set clipboard=unnamed
" tab measures 2 spaces
set tabstop=2
set shiftwidth=2
" convert tabs to spaces
set expandtab
" make search patterns case insensitive
set ignorecase
" make search pattern case sensitive if they include a capital letter
set smartcase
" disable folding
set nofoldenable
" enable enhanced matching e.g. between do/end in ruby
runtime macros/matchit.vim
" show filename at bottom of buffer
set laststatus=2

" key bindings
" ------------
" map :W to write (in case you hold down shift)
command! W w 
command! Wq wq
" fix ambiguous :E for :Explore
cabbrev E Explore
" <leader> o to open a file
map <leader>o :e 
" expand %% to current buffer directory in command
" cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" use 'cp' in normal mode to copy the current path
nmap cp :let @* = expand("%")<CR>
" edit config
nnoremap grc :edit $MYVIMRC<CR>
" reload config
nnoremap grr :source $MYVIMRC<CR>

nnoremap gcoc :edit ~/.vim/plugin/coc_setup.vim<CR>
" move lines in normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" move lines in visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" perform splits same as tmux
nnoremap \| :botright vsp<CR>
nnoremap _ :botright sp<CR>

" =============
" plugin config
" =============
"
" CoC
" ---
" see ~/.vim/plugin/coc_setup.vim

" easy-align
" ----------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap gl <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap gl <Plug>(EasyAlign)

" vim-commentary
" --------------
"  use " comment style for vim files
autocmd FileType vim setlocal commentstring=\"\ %s

" vim-surround
" ------------
let g:surround_{char2nr('o')} = "**\r**"

" ctrl-p
" ------
" bind ctrl-n to show open buffers in ctrlp
map <C-n> :CtrlPBuffer<CR>
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
" Ignore ignore certain directories from ctrl-p searches
" TODO: We also want to ignore these with ack...
set wildignore+=*/tmp/*
set wildignore+=*/logcheck-web/log/*,*/public/logcheck-*
set wildignore+=*/public/ckeditor-*,*/public/packs/*
set wildignore+=*/coverage/*,*/node_modules/*

let g:ctrlp_custom_ignore = '\vnode_modules'

" emmet
" -----
" Add abbreviations for jsx
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends': 'jsx',
\      'quote_char': "'",
\  },
\}
