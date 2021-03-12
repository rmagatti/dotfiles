" !IMPORTANT! Config maps HJKL to JKL:
" I've been trying to shift to these mappings so my brain does not get confused when typing versus using VIM as far as hand position goes.

" Move between splits
map <C-j> :wincmd h<CR>
map <C-k> :wincmd j<CR>
map <C-l> :wincmd k<CR>
map <C-;> :wincmd l<CR>

" Move splits
map <A-j> :wincmd H<CR>
map <A-k> :wincmd J<CR>
map <A-l> :wincmd K<CR>
map <A-;> :wincmd L<CR>

noremap j h
noremap k j
noremap l k
noremap ; l

" Copy to system clipboard mapping
nnoremap cp "+y
vnoremap cp "+y

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
noremap <D-v> :set paste<CR> a<C-r>+<Esc> :set nopaste<CR>
inoremap <D-v> <Esc> :set paste<CR> i<C-r>+<Esc> :set nopaste<CR>
cmap <D-v> <C-r>+

" nnoremap <D-v> a<C-r>+<Esc>
inoremap <D-v> <C-r>+
cnoremap <D-v> <C-r>+

" Paste from external keyboard
tnoremap <D-v> <C-\><C-n>"+pa


":set paste<CR> i<C-r>+ <Esc>:set nopaste<CR>

" Map command-s to save
nnoremap <D-s> :w<CR>
inoremap <D-s> <C-]> :w<CR>

" Re-ource init.vim
noremap <leader>rr :source $HOME/.config/nvim/init.vim<CR>

" Paste without yanking for easier paste repetition
vnoremap p "_dP

" Search from visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Copy file name or path
nmap <leader>cfn :let @+=expand("%")<CR>:echo "Copied: ".@+<CR>
nmap <leader>cfp :let @+=expand("%:p")<CR>:echo "Copied: ".@+<CR>

" Open init.vim in a split
" Mnemonic Open Init Vertical split
" Mnemonic Open Init Split
map <leader>oiv :vsp ~/.config/nvim/init.vim<CR>
map <leader>ois :sp ~/.config/nvim/init.vim<CR>

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

" Open alternate - powered by https://github.com/uptech/alt
" Mnemonic open alternate
" Mnemonic Open Vertical split Alternate
" Mnemonic Open Split Alternate
nnoremap <leader>oa :w<CR>:call AltCommand(expand('%'), ':e')<CR>
nnoremap <leader>ova :w<CR>:call AltCommand(expand('%'), ':vsp')<CR>
nnoremap <leader>osa :w<CR>:call AltCommand(expand('%'), ':sp')<CR>

" Close all buffers but current
nnoremap <leader>cab :%bd <bar> e# <bar> bd#<CR>
nnoremap <leader>cab! :%bd! <bar> e# <bar> bd#<CR>

" Leader mappings for split and vertical split
nnoremap <leader>vsp :vsp<CR>
nnoremap <leader>sp :sp<CR>
nnoremap <leader>q :q<CR>

" Delete all commented lines then save to reformat
nnoremap <leader>dac :g/\v^(\/\/<bar>.*\/\/)/d_<CR>:w<CR>:noh<CR>

" Select line
nnoremap vv V
