" ==============
" vanilla config
" ==============
" turn on syntax highlighting and set colorscheme
syntax on

colorscheme gruvbox

" map :W to write in case you hold down shift too long when typing :w
command! W  write

" move lines around with ctrl-(j|k)
" ---------------------------------
"
" normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" eol       allow backspacing over line breaks (join lines)
" visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" backspacing
" -----------
" indent    allow backspacing over autoindent
" start     allow backspacing over the start of insert; CTRL-W and CTRL-U
"           stop once at the start of insert.
set backspace=indent,eol,start

" swapfiles
" ---------
set wildignore+=*.swp,*~,._*    " disable temp and backup files
set backupdir^=~/.vim/_backup// " where to put backup files (must create this directory)
set directory^=~/.vim/_swap//   " where to put swap files (must create this directory)

" highlighting
" ------------
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

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

call plug#end()
