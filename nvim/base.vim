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
if has("termguicolors")
  set termguicolors
endif
