set relativenumber
set encoding=UTF-8
set splitright
set splitbelow
set noswapfile
" Goneovim options
set guifont=Fira\ Code:h12
let mapleader = " "
autocmd FileType typescript set commentstring=//\ %s
set background=dark
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
set ts=2 sw=2 expandtab

" " performance tweaks
set nocursorline
set nocursorcolumn
set scrolljump=5
" set lazyredraw
set redrawtime=10000
" set synmaxcol=180
" set re=1

set emoji
set undofile                                            " enable persistent undo
set undodir=/tmp                                        " undo temp file directory
set grepprg=rg\ --vimgrep                               " use rg as default grepper
set noshowcmd                                           " to get rid of display of last command

" Plugin configs
let loaded_netrw = 0                                    " diable netew
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines

if has("termguicolors")
  set termguicolors
endif

