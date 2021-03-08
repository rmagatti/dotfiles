set relativenumber
set number
set encoding=UTF-8
set splitright
set splitbelow
set noswapfile

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

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=3

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set emoji
set undofile                                            " enable persistent undo
set undodir=/tmp                                        " undo temp file directory
set grepprg=rg\ --vimgrep                               " use rg as default grepper
set noshowcmd                                           " to get rid of display of last command

" Plugin configs
" let loaded_netrw = 0                                    " diable netew -- enabling it so gx can work
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

augroup mycmds
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup end

" TODO: figure this inactive dimming out
" " Background colors for active vs inactive windows
" hi ActiveWindow guibg=#17252c
" hi InactiveWindow guibg=#0D1B22

" " Call method on window enter
" augroup WindowManagement
"   autocmd!
"   autocmd WinEnter * call Handle_Win_Enter()
" augroup end

" " Change highlight group of active/inactive windows
" function! Handle_Win_Enter()
"   setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
" endfunction

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

" ======== Terminal ========
let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
  if win_gotoid(g:term_win)
    hide
  else
    botright new
    exec "resize" a:height != 0 ? a:height : 20
    try
      exec "buffer " . g:term_buf
    catch
      call termopen($SHELL, {"detach": 0})
      let g:term_buf = bufnr("")
    endtry
    startinsert!
    let g:term_win = win_getid()
  endif
endfunction
command! -nargs=* TermToggle let height = str2nr(expand('<args>')) <bar> call TermToggle(height)

nnoremap <D-CR> call TermToggle(20)

nnoremap <D-j> :call TermToggle(20)<CR>
tnoremap <D-j> <C-\><C-n> :call TermToggle(20)<CR>

command! TogglePresentationMode :call TogglePresentationMode()<CR>
