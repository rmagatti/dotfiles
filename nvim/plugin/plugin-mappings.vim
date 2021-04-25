" ================ vim-dirvish ================
" File exploring - Dirvish
" TODO: figure out opening highlighted dirvish file in splits
command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish
command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %
nnoremap <leader>fs :VLeftDirvish<CR>
nnoremap <leader>ff :VLeftDirvishFile<CR>


" ======== Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gj :diffget //2<CR>
nnoremap g; :diffget //3<CR>

" ====== Zen mode (Goyo)
nnoremap <leader>zz :Goyo<CR>
let g:goyo_width=120
let g:goyo_height=90

" ======== vim-test configs =======
nmap <leader>tt :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR>
nmap <leader>tx :TestLast --onlyFailures<CR>

function! SplitStrategy(cmd)
  vertical new | call termopen(a:cmd) | startinsert
endfunction
let g:test#custom_strategies = {'terminal_split': function('SplitStrategy')}
let g:test#strategy = 'terminal_split'


" Command history mapping, depends on fzf.vim
" cnoremap <Tab> History:<CR>

" " Map Ctrl D (down) F (up) for smooth scrolling
" map <C-d> <Plug>(SmoothieDownwards)
" map <C-f> <Plug>(SmoothieUpwards)

" Map presentation mode toggle
nnoremap <leader>pm :TogglePresentationMode<CR>

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

augroup AlternateToggles
  au!
  au FileType typescript,viml,lua nnoremap <buffer> <CR> :ToggleAlternate<CR>
augroup end

" Open undo tree
nnoremap <leader>u :UndotreeShow<CR>

nnoremap <silent> <leader>gb :<C-u>Git blame<CR>

function! OpenFuzzyFinder()
  if isdirectory(getcwd()."/.git")
    exec ":Telescope git_files"
  else
    exec ":Telescope find_files"
  endif
endfunction

nmap <silent> <C-p> :call OpenFuzzyFinder()<CR>

