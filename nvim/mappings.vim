" !IMPORTANT! Config maps HJKL to JKL:

" Move between splits
nmap <C-j> :wincmd h<CR>
nmap <C-k> :wincmd j<CR>
nmap <C-l> :wincmd k<CR>
nmap <C-;> :wincmd l<CR>

" Move splits
nmap <A-j> :wincmd H<CR>
nmap <A-k> :wincmd J<CR>
nmap <A-l> :wincmd K<CR>
nmap <A-;> :wincmd L<CR>

" Remap movement keys HJKL -> JKL; (all modes)
nnoremap j h
vnoremap j h
onoremap j h

nnoremap k j
vnoremap k j
onoremap k j

nnoremap l k
vnoremap l k
onoremap l k

nnoremap ; l
vnoremap ; l
onoremap ; l

" Navigate folds
nnoremap zk zj
nnoremap zl zk

" Copy to system clipboard mapping
nnoremap cp "+y
vnoremap cp "+y

" Move selection up and down plus formatting
vnoremap K :m '>+1<CR>gv=gv
vnoremap L :m '<-2<CR>gv=gv

" Change CWD to current file path's dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Go to normal mode in terminal window
tnoremap <silent> <C-o><C-i> <C-\><C-n>
tnoremap <silent> <C-_> <C-\><C-n>
" Clear search highlight
map <leader>cs :noh<CR>

" Map command-v in normal insert and command modes to paste from clipboard
nnoremap <D-v> :set paste<CR> a<C-r>+<Esc> :set nopaste<CR>
inoremap <D-v> <Esc> :set paste<CR> i<C-r>+<Esc> :set nopaste<CR>
cmap <D-v> <C-r>+

" nnoremap <D-v> a<C-r>+<Esc>
inoremap <D-v> <C-r>+
cnoremap <D-v> <C-r>+

" Paste from external keyboard
tnoremap <D-v> <C-\><C-n>"+pa

" Force close
nnoremap <leader>Q :q!<CR>

":set paste<CR> i<C-r>+ <Esc>:set nopaste<CR>

" Map command-s to save
nnoremap <D-s> :w<CR>
inoremap <D-s> <esc> :w<CR>

" Re-ource init.vim
noremap <leader>rr :source $HOME/.config/nvim/init.vim<CR>

" Paste without yanking for easier paste repetition
vnoremap p "_dP
xnoremap p "_dP

" Search from visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Copy file name or path
nmap <leader>crp :let @+ = fnamemodify(expand("%"), ":.")<CR>:echo "Copied relativepath: ".@+<CR>

nmap <leader>cap :let @+=expand("%:p")<CR>:echo "Copied absolutepath: ".@+<CR>
nmap <leader>cfn :let @+=expand("%:t")<CR>:echo "Copied filename: ".@+<CR>

" Run a given vim command on the results of alt from a given path.
" See usage below.
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" Open alternate - powered by github.com/uptech/alt
" Mnemonic open alternate
" Mnemonic Open Vertical split Alternate
" Mnemonic Open Split Alternate
nnoremap <leader>oa :w<CR>:call AltCommand(expand('%'), ':e')<CR>
nnoremap <leader>ova :w<CR>:call AltCommand(expand('%'), ':vsp')<CR>
nnoremap <leader>osa :w<CR>:call AltCommand(expand('%'), ':sp')<CR>

" Leader mappings for split and vertical split
nnoremap <leader>vsp :vsp<CR>
nnoremap <leader>sp :sp<CR>
nnoremap <leader>q :q<CR>

" " Delete all commented lines then save to reformat
nnoremap <leader>dac :g/\v^(\/\/<bar>.*\/\/)/d_<CR>:w<CR>:noh<CR>

" " Select line
" nnoremap vv V

" Buffer next/previous
nnoremap <leader>; <cmd>bn<CR>
nnoremap <leader>j <cmd>bp<CR>

" Tab navigation numbered
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 5gt
nnoremap <leader>7 5gt
nnoremap <leader>8 5gt
nnoremap <leader>9 5gt

" Tab navigation
nnoremap tj :tabprev<CR>
nnoremap t; :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>

" Paste today's date 
nnoremap <leader>. "=strftime('%a %d %b %Y')<CR>P
inoremap <C-d> <C-r>=strftime('%a %d %b %Y')<CR>

" Vimwiki
augroup vimwikigroup
    au!
    " automatically update links on read diary
    au BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
augroup end

nnoremap <leader>mk "ayy
nnoremap <leader>rk @a

let g:diff_is_open = 0

function! ToggleDiff()
  if g:diff_is_open
    windo diffoff
    let g:diff_is_open = 0
  else
    windo diffthis
    let g:diff_is_open = 1
  endif
endfunction

" Diff this
nnoremap <leader>dt <cmd>call ToggleDiff()<CR>

" Quickfix next/prev/open
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>

" Conceal level for markdown
augroup markdown
  autocmd!
  autocmd FileType markdown setlocal conceallevel=2
augroup end
