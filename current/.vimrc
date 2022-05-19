
let g:gruvbox_contrast_light='hard'
let g:gruvbox_contrast_dark='hard'

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
" set colorscheme
colorscheme gruvbox
set background=light
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
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" use 'cp' in normal mode to copy the current path
nmap cp :let @* = expand("%")<CR>
" edit config
nnoremap gec :e $MYVIMRC<CR>
" reload config
nnoremap grc :so $MYVIMRC<CR>
" move lines in normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" move lines in visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" =============
" plugin config
" =============

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

" ale
" ---
" let g:ale_sign_error = '●' " Less aggressive than the default '>>'
" let g:ale_sign_column_always = 1
" let g:ale_sign_warning = '.'
" let g:ale_lint_on_enter = 1
" let g:ale_set_highlights = 0
" let g:ale_completion_enabled = 1

" CoC
" ---
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-eslint'
  \ ]

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab to navigate completion lists.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Show show documentation on hover when a diagnostic isn't present
"
" NOTE: If you then want to see documentation for something that has diagnostic,
" use K (see above)
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" TODO: replace with Prettier?
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

nmap <leader>do <Plug>(coc-codeaction)
" Show lists
nmap <leader>d :<C-u>CocList diagnostics<cr>
nmap <leader>s :<C-u>CocList -I symbols<cr>

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
