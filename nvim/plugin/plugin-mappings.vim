" ================ vim-dirvish ================

" Map presentation mode toggle
nnoremap <leader>pm :TogglePresentationMode<CR>

" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

augroup AlternateToggles
  au!
  au FileType typescript,viml,lua nnoremap <buffer> <CR> :ToggleAlternate<CR>
augroup end

function! OpenFuzzyFinder()
  if isdirectory(getcwd()."/.git")
    exec ":Telescope git_files"
  else
    exec ":Telescope find_files"
  endif
endfunction

nmap <silent> <C-p> :call OpenFuzzyFinder()<CR>
nmap <silent> <C-f> :Telescope find_files<CR>

