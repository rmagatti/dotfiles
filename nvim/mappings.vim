" Avoid unecessary shift key press
:nmap ; :
" Move between splits
map <C-h> :wincmd h<CR>
map <C-j> :wincmd j<CR>
map <C-k> :wincmd k<CR>
map <C-l> :wincmd l<CR>
map <C-o> :wincmd o<CR>

" Move selection up and down plus formatting
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Change CWD to current file path's dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Go to normal mode in terminal window
tnoremap <silent> <C-o><C-i> <C-\><C-n>

" Clear search highlight
map <leader>cs :noh<CR>

