" ======== Terminal ========
let g:term_buf = 0
let g:term_win = 0


" TODO: Can be improved to keep last window placement, maybe?
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
      exec "file terminal"
    endtry
    startinsert!
    let g:term_win = win_getid()
  endif
endfunction
command! -nargs=* TermToggle let height = str2nr(expand('<args>')) <bar> call TermToggle(height)

nnoremap <D-CR> call TermToggle(20)

nnoremap <D-j> :call TermToggle(20)<CR>
tnoremap <D-j> <C-\><C-n> :call TermToggle(20)<CR>
tnoremap <D-k> <C-\><C-n> :bd! g:term_buf<CR>
