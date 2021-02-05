set relativenumber
set number
set encoding=UTF-8
set splitright
set splitbelow
set noswapfile
set termguicolors

set mouse=a
" set shada
" Goneovim options TODO: figure out a way to no repeat font name for presentation mode
set guifont=FiraCode\ Nerd\ Font"
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
" set ttyfast
" set redrawtime=10000
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

" Custom autocmds
augroup goyocmds
  autocmd!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!
augroup end

" Presentation Mode
let g:in_presentation_mode = 0
function! TogglePresentationMode()
  if g:in_presentation_mode
    let g:in_presentation_mode = 0
    set guifont=FiraCode\ Nerd\ Font:h12
    Goyo!
  else
    let g:in_presentation_mode = 1
    set guifont=FiraCode\ Nerd\ Font:h30
    " Default Goyo options, just need to use them since I don't want the toggling behaviour to trigger at all.
    Goyo 80x85%
  endif
endfunction

command! TogglePresentationMode :call TogglePresentationMode()<CR>
