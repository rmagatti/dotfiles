" TODO: convert this to lua

set relativenumber
set number
set encoding=UTF-8
set splitright
set splitbelow
set noswapfile

set mouse=a
" set shada
" Goneovim options TODO: figure out a way to no repeat font name for presentation mode
set guifont=JetBrains_Mono:12
let mapleader = " "
set background=dark
set ts=2 sw=2 expandtab
set signcolumn=yes
set sessionoptions+=winpos,terminal

" augroup typescript
"   au!
"   autocmd FileType typescript set commentstring=//\ %s
"   autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
" augroup end

" " performance tweaks
set nocursorline
set nocursorcolumn
set scrolljump=5
" set lazyredraw
" set ttyfast
set redrawtime=3000
" set synmaxcol=180
" set re=1

set hidden
set syntax=on

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

let &undodir = expand(stdpath('data')."/undodir")
set grepprg=rg\ --vimgrep                               " use rg as default grepper
set showcmd                                           " to get rid of display of last command

" augroup RemoveNoNameBufs
"   au!
"   " FIXME: this does not work. Not closing the buffer for some stupid reason.
"   autocmd BufHidden * if bufname() == '' | echo "bdelete ".bufnr() | exec "bdelete ".bufnr() | endif
" augroup end

" Show search match counter
set shortmess-=S

" Store global vars in sessions
" set sessionoptions+=globals
" set viminfo+=!

" Plugin configs
" let loaded_netrw = 0                                    " diable netew -- enabling it so gx can work
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

augroup annoying
  au!
  au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
augroup end

if has("termguicolors")
  set termguicolors
endif

" Custom autocmds
augroup goyocmds
  autocmd!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!
augroup end

augroup AutoAdjustResize
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
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

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup end

" Fold defaults
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
set nofoldenable " do not fold by default

" Protip: zi toggles folding
function! Fold()
  set foldenable
  " normal zM
endfunction

function! Unfold()
  " normal zR
  set nofoldenable
endfunction

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call Fold()
command! -nargs=? Unfold :call Unfold()

"" Figure out if I'll use this or not
" function! s:CompareQuickfixEntries(i1, i2)
"   if bufname(a:i1.bufnr) == bufname(a:i2.bufnr)
"     return a:i1.lnum == a:i2.lnum ? 0 : (a:i1.lnum < a:i2.lnum ? -1 : 1)
"   else
"     return bufname(a:i1.bufnr) < bufname(a:i2.bufnr) ? -1 : 1
"   endif
" endfunction

" function! s:SortUniqQFList()
"   let sortedList = sort(getqflist(), 's:CompareQuickfixEntries')
"   let uniqedList = []
"   let last = ''
"   for item in sortedList
"     let this = bufname(item.bufnr) . "\t" . item.lnum
"     if this !=# last
"       call add(uniqedList, item)
"       let last = this
"     endif
"   endfor
"   call setqflist(uniqedList)
" endfunction
" autocmd! QuickfixCmdPost * call s:SortUniqQFList()
