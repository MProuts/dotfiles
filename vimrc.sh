execute pathogen#infect()
filetype plugin indent on
set autoindent
"set background=dark
syntax enable
set t_Co=256
set background=light
set noswapfile
let g:solarized_termcolors=256
colorscheme solarized
"Auto Completion AND normal tabs in insert mode
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

"Key Mappings
"============
map <C-n> :NERDTreeToggle<CR> 
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
"map <S-n> :tabnew<CR>
map <S-w> :wq<CR>
map <S-q> :qa<CR>
map <S-s> :wqa<CR>
imap <C-tab> <C-P>
let NERDTreeShowHidden=1
set tabstop=2
set shiftwidth=2
set expandtab
"show line numbering
set number

"textwidth=80
set tw=80

"formatoptions
set fo=tcqwa

"highlight 80th column
set colorcolumn=81

"backspace
set backspace=indent,eol,start

" Spec.vim mappings
map <Leader>f :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Vundle
" ======

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'thoughtbot/vim-rspec'
" vim-scripts repos
" Bundle 'FuzzyFinder'
" non-GitHub repos
" Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
" Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

filetype plugin indent on     " required!
