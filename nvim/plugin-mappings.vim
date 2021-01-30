source $HOME/.config/nvim/coc-mappings.vim

" ================ vim-dirvish ================
" File exploring - Dirvish
" TODO: figure out opening highlighted dirvish file in splits
command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish
command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %
nnoremap <leader>fs :VLeftDirvish<CR>
nnoremap <leader>ff :VLeftDirvishFile<CR>

function! OpenFuzzyFinder()
  if isdirectory(getcwd()."/.git")
    exec ":CocCommand fzf-preview.ProjectFiles"
  else
    exec ":CocCommand fzf-preview.DirectoryFiles"
  endif
endfunction

nmap <silent> <C-P> :call OpenFuzzyFinder()<CR>

" ======== Fugitive Conflict Resolution
nnoremap <leader>dd :Gdiffsplit!<CR>
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


" ======== Terminal ========
let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
  if win_gotoid(g:term_win)
    hide
  else
    botright new
    exec "resize " . a:height ? a:height : 25
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

nnoremap <D-j> :call TermToggle(25)<CR>
tnoremap <D-j> <C-\><C-n> :call TermToggle(25)<CR>

" Go to normal mode in terminal window
" tnoremap <silent> <C-[><C-[> <C-\><C-n>
" Go to normal mode in terminal window and toggle terminal
" tnoremap <silent> <D-j> <C-\><C-n> :CocCommand terminal.Toggle<CR>
" Destroy terminal
tnoremap <silent> <D-J> <C-\><C-n> :CocCommand terminal.Destroy<CR>
" Enter REPL mode relative to current working dir
nnoremap <leader>rp :CocCommand terminal.REPL<CR>

" Command history mapping, depends on fzf.vim
" cnoremap <Tab> History:<CR>

" " Map Ctrl D (down) F (up) for smooth scrolling
" map <C-d> <Plug>(SmoothieDownwards)
" map <C-f> <Plug>(SmoothieUpwards)

" Map presentation mode toggle
nnoremap <leader>pm :TogglePresentationMode<CR>

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
