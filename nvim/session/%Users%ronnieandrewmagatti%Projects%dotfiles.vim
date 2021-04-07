let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Projects/dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +110 nvim/lua/rmagatti/auto-session-telescope.lua
badd +36 nvim/coc-settings.json
badd +36 ~/Projects/autoreggol/src/method-decorators.ts
badd +4 ~/Projects/autoreggol/src/propery-decorators.ts
badd +0 nvim/telescope.vim
argglobal
%argdel
edit nvim/lua/rmagatti/auto-session-telescope.lua
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 172 + 172) / 345)
exe 'vert 2resize ' . ((&columns * 172 + 172) / 345)
argglobal
balt nvim/telescope.vim
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 110 - ((84 * winheight(0) + 43) / 87)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 110
normal! 02|
wincmd w
argglobal
if bufexists("nvim/telescope.vim") | buffer nvim/telescope.vim | else | edit nvim/telescope.vim | endif
if &buftype ==# 'terminal'
  silent file nvim/telescope.vim
endif
balt nvim/lua/rmagatti/auto-session-telescope.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 2 - ((1 * winheight(0) + 43) / 87)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 172 + 172) / 345)
exe 'vert 2resize ' . ((&columns * 172 + 172) / 345)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOFIc
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
