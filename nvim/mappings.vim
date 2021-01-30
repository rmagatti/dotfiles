" !IMPORTANT! Config maps HJKL to JKL:
" I've been trying to shift to these mappings so my brain does not get confused when typing versus using VIM as far as hand position goes.

" Move between splits
map <C-j> :wincmd h<CR>
map <C-k> :wincmd j<CR>
map <C-l> :wincmd k<CR>
map <C-;> :wincmd l<CR>

noremap j h
noremap k j
noremap l k
noremap ; l

xnoremap <leader>p "_dP

" Move selection up and down plus formatting
vnoremap K :m '>+1<CR>gv=gv
vnoremap L :m '<-2<CR>gv=gv

" Change CWD to current file path's dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Go to normal mode in terminal window
tnoremap <silent> <C-o><C-i> <C-\><C-n>

" Clear search highlight
map <leader>cs :noh<CR>

" Map command-v in normal insert and command modes to paste from clipboard
noremap <D-v> :set paste<CR> i<C-r>+<Esc> :set nopaste<CR>
inoremap <D-v> <Esc> :set paste<CR> i<C-r>+<Esc> :set nopaste<CR>
cmap <D-v> <C-r>+

nnoremap <D-v> a<C-r>+<Esc>
inoremap <D-v> <C-r>+
cnoremap <D-v> <C-r>+
tnoremap <D-v> <C-\><C-n> <C-r>+

":set paste<CR> i<C-r>+ <Esc>:set nopaste<CR>

" Map command-s to save
nnoremap <D-s> :w<CR>
inoremap <D-s> <C-]> :w<CR>

" Re-ource init.vim
noremap <leader>rr :source $HOME/.config/nvim/init.vim<CR>

" Paste without yanking for easier paste repetition
vnoremap p "_dP

